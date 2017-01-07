# Pulls custom perl build and lib settings out of a zsh environment, so that
# subsequent work with a perlbrew or perl-build type environment is not
# confused by whatever defaults I have. (Also serves as a handy reminder
# of the zsh array "grep" syntax which you can read about in zshexpn(1).)
unset PERL_LOCAL_LIB_ROOT PERL_MB_OPT PERL_MM_OPT PERL5LIB PERL_MM_USE_DEFAULT
path=( ${(m)path:#*perl*} )
