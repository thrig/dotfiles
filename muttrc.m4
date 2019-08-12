include(`m4/cf.m4')dnl
divert(-1)
asociar(`CUR_HOME', `printf "$HOME"')
divert(0)dnl
source ~/.muttrc-gpg
divert(-1)
CVE-2019-10736 mitigation
divert(0)dnl
set include_onlyfirst=yes
alternates TODOFIXME
set from=TODOFIXME
set charset=UTF-8
set ascii_chars=yes
set send_charset=UTF-8
uncolor index *
uncolor header *
uncolor body *
mono header underline ^(From|Subject):
mono quoted bold
bind index <up> noop
bind index <down> noop
bind pager <up> noop
bind pager <down> noop
bind index ' ' next-page
bind index - previous-page
bind index R reply
bind index j next-entry
bind index k previous-entry
bind index p noop
bind index r group-reply
bind index x sync-mailbox
bind pager ' ' next-page
bind pager G check-traditional-pgp
bind pager R reply
bind pager j next-entry
bind pager k previous-entry
bind pager r group-reply
macro index H c!\r
macro index S c=sent\r
macro index V c!!\r
macro index \cb |urlview\n
macro pager H c!\r
macro pager S c=sent\r
macro pager V c!!\r
macro pager \cb |urlview\n
set editor="comando(`vim', `-N -u CUR_HOME/.muttrc-vimrc')"
set visual="comando(`vim', `-N -u CUR_HOME/.muttrc-vimrc')"
set abort_nosubject=no
set abort_unmodified=no
set attribution=".i la %n <%a> pu ciska"
set autoedit=yes
set beep_new=no
set confirmappend=no
set date_format="%Y-%m-%d %H:%M:%S %Z"
set delete=yes
set edit_headers=yes
set folder=~/mail
set folder_format="%2C %t %N %f %> %8s  %d "
set forward_format="%s (fwd)"
set hidden_host=yes
set index_format="%3C %Z %{%b %d}  %-16.16F  %s"
set markers=no
set mbox_type=maildir
set menu_scroll=yes
set move=no
set pager_context=2
set pager_format="%> [lines:%l %c]"
set pager_index_lines=4
set pager_stop=yes
set postpone=no
set postponed=+postponed
set record=+sent/
set sendmail="comando(`msmtp', `-a gmail')"
set sig_dashes=no
set sleep_time=0
set smart_wrap=yes
set spoolfile=+inbox/
set status_format="%f [msgs:%?M?%M/?%m%?n? new:%n?%?o? old:%o?%?d? del:%d?%?F? flag:%F?%?t? tag:%t?%?p? post:%p?%?b? inc:%b?%?l? %l?] %> %s  %P"
set status_on_top
set tilde
set use_domain
set wrap_search
set write_inc=0
unset mbox
unset strict_threads
unset signature
unset mark_old
folder-hook . set sort=threads
folder-hook . set sort_aux=date-received
folder-hook sent set sort=date-sent
ignore *
unignore from: date subject to cc reply-to
unhdr_order *
hdr_order From: Date: To: Reply-To: Cc: Subject:
