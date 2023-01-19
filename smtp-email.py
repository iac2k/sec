#!/usr/bin/env python

import argparse
import traceback
import re
import smtplib


mailServer = "smtp.yourdomain.com"
fromAddr = "from@yourdomain.com"
toAddr = "to@yourdomain.com"

def mailfunc(subject,body,smtpServer):
    from email.mime.multipart import MIMEMultipart
    from email.mime.text import MIMEText
    msg = MIMEMultipart('alternative')
    msg['Subject'] = subject
    msg['From'] = fromAddr
    msg['To'] = toAddr
    msg['CC'] = ''
    toaddrs = msg['To'].split(",") +  msg['CC'].split(",")
    part = MIMEText(body, 'html')
    msg.attach(part)
    try:
        s = smtplib.SMTP(smtpServer)
    except Exception as err:
        print("failure on " +  mailServer + err.args[0])
        try:
            s = smtplib.SMTP(mailServer2)
        except Exception as err:
            print("failure on " +  mailServer2 + err.args[0])
            return

    try:
        s.sendmail(fromAddr, toaddrs, msg.as_string())
        s.quit()
    except Exception as err:
        print(type(err) + err.args[0])

def main():
    global toAddr
    parser = argparse.ArgumentParser()
    parser.add_argument("-s", help="email subject")
    parser.add_argument("-r", help="email sent to")
    parser.add_argument("-b", help="email body text")
    parser.add_argument("-m", help="SMTP Server", default=mailServer)

    args = parser.parse_args()

    if args.m:
        smtpServer = args.m
    else:
        smtpServer = mailServer


    mailfunc(args.s, args.b, smtpServer)


if __name__ == '__main__':
     main()
