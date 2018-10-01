# -*- coding: utf-8 -*
import threading
from pygame import mixer
from datetime import datetime
from os import path


class Focus:
    dirname = path.dirname(path.abspath(__file__))
    logfile = path.join(dirname, 'log.json')
    forcus_music = path.join(dirname, '_music', 'forcus.ogg')
    break_music = path.join(dirname, '_music', 'break.ogg')
    fin_music = path.join(dirname, '_music', 'fin.ogg')

    def __init__(self, focus_time, break_time, content):
        self.content = content
        self.focus_time = focus_time * 60
        self.break_time = break_time * 60
        self.start_time = None
        self.end_time = None
        self.fin = 1

    def _logging(self):
        import json
        if path.exists(self.logfile):
            f = open(self.logfile)
            dics = json.load(f)
        else:
            dics = []

        dics.append({
            'content': self.content,
            'start_time': self.start_time.strftime('%Y/%m/%d %H:%M:%S'),
            'end_time': self.end_time.strftime('%Y/%m/%d %H:%M:%S')
        })

        with open(self.logfile, 'w') as f:
            json.dump(dics, f, sort_keys=True, indent=4)

    def _focus_on(self):
        now = datetime.now()
        mixer.music.stop()
        mixer.music.load(self.fin_music)
        mixer.music.play(1)

        mixer.music.load(self.break_music)
        mixer.music.play(-1)
        print(u"休憩開始: {0}".format(now.strftime('%H:%M:%S')))
        focus_off = threading.Timer(self.break_time, self._focus_off)
        focus_off.start()

    def _focus_off(self):
        mixer.music.stop()
        mixer.music.load(self.fin_music)
        mixer.music.play(1)
        self.end_time = datetime.now()
        self._yes_no_input()

    def _yes_no_input(self):
        choice = raw_input("Do you keep your work 'yes' or 'no' [y/N]: ").lower()
        if choice in ['y', 'ye', 'yes']:
            focus_on = threading.Timer(1, self.main)
            focus_on.start()
        elif choice in ['n', 'no']:
            self._logging()
            print('お疲れ様でした')

    def main(self):
        if not self.start_time:
            self.start_time = datetime.now()

        print('=====================================')
        print('{0} を開始: {1}'.format(self.content, self.start_time.strftime('%Y/%m/%d %H:%M:%S')))
        print('=====================================')
        mixer.init()
        mixer.music.load(self.forcus_music)
        mixer.music.play(-1)
        focus_on = threading.Timer(self.focus_time, self._focus_on)
        focus_on.start()


if __name__ == "__main__":
    from sys import argv
    args = argv
    if args:
        f = Focus(25, 15, args[1])
        f.main()
    else:
        print(u'作業内容を入力してください')
