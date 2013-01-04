setopt EXTENDED_GLOB
for rcfile in `pwd`/.prezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" ~/.${rcfile:t}
done
ln -s `pwd`/.zprezto ~/.prezto
