#! /bin/zsh

EXEC_FILES=$(ls go/**/*(*) | grep -E -v '\.rc$|\.pl$|^go/misc/|^go/src/cmd/vendor/|^go/pkg/bootstrap/bin/|testdata|^go/bin/go$')
# echo ${EXEC_FILES}

# echo ""
# echo ""
# echo "# files"
# for e in ${=EXEC_FILES}
# do
#     echo "\t${e} \\"
# done


echo ""
echo ""
echo "# trusted files"
for e in ${=EXEC_FILES}
do
    # f=${e:t}
    f=${e//\//_}
    f=${f//\./_}
    echo "sgx.trusted_files.${f} = file:\$(GOROOTDIR)/${e}"
done

echo ""
echo ""
echo "# trusted children"
for e in ${=EXEC_FILES}
do
    # f=${e:t}
    f=${e//\//_}
    f=${f//\./_}
    echo "sgx.trusted_children.${f} = file:\$(GOROOTDIR)/${e:t}.sig"
done
