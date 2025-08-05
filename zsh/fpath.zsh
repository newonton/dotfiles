# add each topic folder to fpath so that they can add functions and completion scripts
for topic_folder ($ZSH/*) if test -d $topic_folder; then  FPATH=$topic_folder:$FPATH; fi;
