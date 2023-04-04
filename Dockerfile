FROM ubuntu:20.04
RUN apt-get update && apt-get install cron curl jq bc -y

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

