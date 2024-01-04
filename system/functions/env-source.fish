function env-source -d "load env file for the current shell"
    for i in (cat $argv)
        set arr (echo $i |tr = \n)
        if not test -z $arr[1] && string match -q -r "^[a-zA-Z_-]+" $arr[1]
            set -gx $arr[1] $arr[2]
        end
    end
end
