#! /bin/zsh

EXEC_FILES=$(ls go/**/*(*) | grep -E -v '\.rc$|\.pl$|^go/misc/|^go/src/cmd/vendor/')
# echo ${EXEC_FILES}


for e in ${=EXEC_FILES}
do
    echo "\t${e} \\"
done

for e in ${=EXEC_FILES}
do
    f=${e//\//_}
    f=${f//\./_}
    echo "sgx.trusted_files.${f} = file:${e}"
done

for e in ${=EXEC_FILES}
do
    f=${e//\//_}
    f=${f//\./_}
    echo "sgx.trusted_children.${f} = file:${f}.sig"
done
