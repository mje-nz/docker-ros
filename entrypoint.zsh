#!/usr/bin/zsh
set -e

# Fill in the history a bit so it's comfy
HISTFILE=/root/.zsh_history
function add_to_history() {
    echo ": $(date +%s):0;$1" >> $HISTFILE
}
add_to_history "apt update"
add_to_history "catkin_make run_tests"
add_to_history "catkin_test_results"
add_to_history "catkin_make install"
add_to_history ". install/setup.zsh"
add_to_history "catkin_make"
add_to_history ". devel/setup.zsh"
for f in $(ls src 2>/dev/null); do
    add_to_history "cd src/$d"
done

exec "$@"
