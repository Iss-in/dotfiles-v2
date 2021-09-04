from i3ipc import Connection, Event
from threading import Thread
from time import sleep


AC_TRANS   = 1        # opacity of active window
INAC_TRANS = 0.7      # opacity of inactive windows
FLOAT_INAC = 0.9      # opacity of inactive floating windows
FADE_TIME  = 0.2      # time taken for fade to complete
FRAME_T    = 0.01     # time between each opacity change


class Fader:
    def __init__(self):
        self.fader_running = False
        self.fade_queue = []
        self.fade_data = {}
        self.current_win = None
        self.new_win = None

        ipc = Connection()
        ipc.on(Event.WINDOW_FOCUS, self.on_window_focus)
        ipc.on(Event.WINDOW_NEW, self.on_window_new)
        ipc.on(Event.WINDOW_FLOATING, self.on_window_floating)

        for win in ipc.get_tree():
            if win.focused:
                change_opacity(win, AC_TRANS)
                self.current_win = win
            else:
                change_opacity(win, INAC_TRANS)

        ipc.main()


    def add_fade(self, win, start, target, duration):
        if win.id in self.fade_queue:
            f = self.fade_data[win.id]
            change = (FRAME_T / duration) * (target - f['opacity'])
            f['change'] = change
            f['target'] = target

        else:
            change_opacity(win, start)
            change = (FRAME_T / duration) * (target - start)
            fade_data = {'opacity': start,
                         'change': change,
                         'target': target,
                         'win': win}

            self.fade_queue.append(win.id)
            self.fade_data[win.id] = fade_data


    def start_fader(self):
        if not self.fader_running:
            self.fader_running = True
            Thread(target=self.fader).start()


    def fader(self):
        while self.fade_queue:
            for win_id in self.fade_queue.copy():
                f = self.fade_data[win_id]
                f['opacity'] += f['change']

                finished = False
                if f['change'] > 0:
                    if f['opacity'] >= f['target']:
                        finished = True
                elif f['opacity'] <= f['target']:
                    finished = True

                if finished:
                    change_opacity(f['win'], f['target'])
                    self.fade_queue.remove(win_id)
                    del self.fade_data[win_id]

                else:
                    change_opacity(f['win'], f['opacity'])

            sleep(FRAME_T)
        self.fader_running = False


    def on_window_focus(self, ipc, e):
        if self.current_win.id == e.container.id:
            return

        if self.current_win.type == 'floating_con':
            trans = FLOAT_INAC
        else:
            trans = INAC_TRANS

        if e.container.id == self.new_win:
            change_opacity(self.current_win, trans)
            change_opacity(e.container, AC_TRANS)
        else:
            self.add_fade(self.current_win, AC_TRANS, trans, FADE_TIME)
            if e.container.type == 'floating_con':
                self.add_fade(e.container, FLOAT_INAC, AC_TRANS, FADE_TIME)
            else:
                self.add_fade(e.container, INAC_TRANS, AC_TRANS, FADE_TIME)
            self.start_fader()

        self.current_win = e.container
        self.new_win = None


    def on_window_new(self, ipc, e):
        if e.container.type == 'floating_con':
            change_opacity(e.container, FLOAT_INAC)
        else:
            change_opacity(e.container, INAC_TRANS)
        self.new_win = e.container.id


    def on_window_floating(self, ipc, e):
        if e.container.id == self.current_win.id:
            self.current_win = e.container


def change_opacity(win, trans):
    win.command('opacity ' + str(trans))


if __name__ == "__main__":
    Fader()
