FROM ubuntu:20.04
RUN apt-get update && apt-get install cron curl jq bc -y

# copy cron to folder get permission and add it to crontab
COPY cron /etc/cron.d/pollencron
RUN chmod 0644 /etc/cron.d/pollencron
RUN crontab /etc/cron.d/pollencron

# create log file
WORKDIR /app
RUN touch log
RUN ln -sf /proc/1/fd/1 log

#Get entrypoint
COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

#Get the script
COPY script.sh script.sh
RUN chmod +x script.sh

# run cron
ENTRYPOINT ["./entrypoint.sh"]

