FROM kasmweb/core-ubuntu-noble:1.18.0-rolling-weekly
USER root

ENV HOME=/home/kasm-default-profile
ENV STARTUPDIR=/dockerstartup
ENV INST_SCRIPTS=$STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########
# 1. update system
COPY setup_env.sh /tmp/
RUN /tmp/setup_env.sh && rm /tmp/setup_env.sh

# 2. update UI
COPY theme /tmp/theme
RUN chmod +x /tmp/theme/install_theme.sh \
    && /tmp/theme/install_theme.sh\
    && rm -rf /tmp/theme

# 3. install application

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME=/home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000