safeupdatemirrors() {
    local base
    local tempfile
    base="/etc/pacman.d"
    tempfile="/tmp/supertemomirror987654"
    if [ -f $base/etc/pacman.d/mirrorlist.pacnew ]; then
        sed '/#Server/ s|#|| ' -i $base/mirrorlist.pacnew
        sed '/^#.*$/d' -i $base/mirrorlist.pacnew
        cp $base/mirrorlist $tempfile
        rankmirrors -n 6 $base/mirrorlist.pacnew > $base/mirrorlist
        if [ $? -eq 0 ]; then
           rm $base/mirrorlist.pacnew
            echo "Mirror list updated"
        else
            cp $tempfile $base/mirrorlist
            echo "Failed to update mirror list"
        fi
        rm $tempfile
    fi
}
safeupdatemirrors
