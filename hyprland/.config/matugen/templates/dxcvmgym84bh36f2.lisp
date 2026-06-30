;;
;; ╔═══╗ ╔╗             ╔╗╔╗╔╗╔═╗╔═╗
;; ║╔═╗║╔╝╚╗            ║║║║║║║║╚╝║║
;; ║╚══╗╚╗╔╝╔╗╔╗╔╗╔╗╔══╗║║║║║║║╔╗╔╗║
;; ╚══╗║ ║║ ║║║║║╚╝║║╔╗║║╚╝╚╝║║║║║║║
;; ║╚═╝║ ║╚╗║╚╝║║║║║║╚╝║╚╗╔╗╔╝║║║║║║
;; ╚═══╝ ╚═╝╚══╝╚╩╩╝║╔═╝ ╚╝╚╝ ╚╝╚╝╚╝
;;                  ║║
;;  CONFIG FILES    ╚╝
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Setup

#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

(in-package :stumpwm)

;; -- Contrib resources --
(set-module-dir (merge-pathnames ".config/contrib/"
				 (user-homedir-pathname)))

;; Load contrib modules
(load-module "urgentwindows")

;; Load rest of config files
(mapcar
 #'(lambda (file) (load (data-dir-file file "lisp")))
 '("theme"
   "commands"
   "fonts"
   "modeline"
   "keybindings"
   "groups"
   "slynk"
   "media"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Basics

(setf *shell-program* (getenv "SHELL")
      *startup-message* nil
      ;; Message and input bar
      *maximum-completions* 20
      *message-window-gravity* :top-left
      *input-window-gravity* :center
      ;; Windows
      *window-name-source* :title
      *ignore-wm-inc-hints* t
      *suppress-window-placement-indicator* t
      *suppress-frame-indicator* t
      ;; Mouse
      *mouse-focus-policy* :click
      ;; Frames
      *frame-number-map* "aoeuidhtns")

(set-prefix-key (kbd "s-t"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Windows

;; Automatic reordering of window numbers
;; XXX Doesn't work when moving a window to another group
;; (add-hook *destroy-window-hook* #'(lambda (win) (repack-window-numbers)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Keyboard / touchpad

(run-shell-command "synclient MaxTapTime=0") ; disable touchpad click (laptop)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Screen

;; Don't turn off the screen
(run-shell-command "xset s off && xset -dpms && xsen s noblank")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Startup

(when *initializing*
  (progn
    (set-keyboard)
    (start-server)
    (luakit)
    (terminal)
    (emacs-daemon)
    ;; (signal-desktop)
    ;; (vesktop)
    ;; (mail)
    ))

(update-screen)

(define-minor-mode meow-motion-mode () ()
  (:scope :screen)
  (:interactive t)
  (:top-map '(("i" . "meow-motion-mode")
              ("t" . "move-focus right")
              ("h" . "move-focus left")
              ("p" . "move-focus up")
              ("n" . "move-focus down")
              ("o" . "fother")
              ("s" . "vsplit")
              ("S" . "hsplit")
              ("P" . "gprev")
              ("N" . "gnext")
              ("a" . "gother")))
  (:lighter-make-clickable nil)
  (:lighter "MEOW"))

(define-minor-mode swm-evil-mode () ()
  (:scope :screen)
  (:interactive t)
  (:top-map '(("i" . "swm-evil-mode")
              ("j" . "move-focus down")
              ("k" . "move-focus up")
              ("h" . "move-focus left")
              ("l" . "move-focus right")
              ("p" . "pull-hidden-previous")
              ("n" . "pull-hidden-next")
              ("S" . "hsplit")
              ("s" . "vsplit")
              ("r" . "remove-split")
              ("g" . *groups-map*)
              ("x" . *exchange-window-map*)))
  (:lighter-make-clickable nil)
  (:lighter "EVIL"))
