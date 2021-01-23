FROM tiangolo/uwsgi-nginx:python3.8

LABEL maintainer="Pritam Sarkar <001pritam2012@gmail.com>"

#RUN make setup
#
## Move the base entrypoint to reuse it
#RUN mv /entrypoint.sh /uwsgi-nginx-entrypoint.sh
## Copy the entrypoint that will generate Nginx additional configs
#COPY entrypoint.sh /entrypoint.sh
#RUN chmod +x /entrypoint.sh
#
#ENTRYPOINT ["/entrypoint.sh"]

# Run the start script provided by the parent image tiangolo/uwsgi-nginx.
# It will check for an /app/prestart.sh script (e.g. for migrations)
# And then will start Supervisor, which in turn will start Nginx and uWSGI
#CMD ["/prestart.sh"]
