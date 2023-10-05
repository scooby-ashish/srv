include:
  - myuser.user

install_git:
  pkg.installed:
    - name: git

clone_dotfiles:
  git.latest:
    - name: https://github.com/scooby-ashish/dotfiles.git
    - rev: master
    - target: /home/scooby-ashish/dotfiles
    - user: scooby-ashish
    - submodules: True
    - require:
      - pkg: install_git
      - user: add_user_scooby_ashish

install_dotfiles_if_changed:
  cmd.run:
    - name: 'python install.py -y'
    - cwd: '/home/scooby-ashish/dotfiles'
    - user: scooby-ashish
    - onchanges:
      - git: clone_dotfiles
