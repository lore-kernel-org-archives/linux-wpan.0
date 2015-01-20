Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:61455 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbbATM2q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Jan 2015 07:28:46 -0500
Received: by mail-we0-f169.google.com with SMTP id p10so13359799wes.0
        for <linux-wpan@vger.kernel.org>; Tue, 20 Jan 2015 04:28:45 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 20 Jan 2015 17:58:45 +0530
Message-ID: <CAAkG1NOO3ScSHG7x+LgU6Min8OP-vcihwXwmLH7JSzGeVw8tyQ@mail.gmail.com>
Subject: Device or resource busy
From: Rohit Kulkarni <rmkulkar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

When trying to set the pan_id for a node, I keep getting device or
resource busy. the "ifdown wpan1" says "interface wpan1 not
configured". "ifconfig wpan1 down" doesn't throw an error but it seems
to be a no-op.  (wpan0 is the fake radio interface and wpan1 is the
at86rf212b module. Also, the error's the same for the wpan0
interface). There was an email on the list about a month ago with the
same problem. Have there been any updates on the issue?

I'm using the tip of the bluetooth-next kernel and the release tarball
for wpan-tools-0.3 on a raspberry pi attached to an at86rf212b module
over spi. Please let me know if I missed out on any relevant info.

Also, when I try to create a coordinator node, I get an "invalid
argument" error. I've added the netlink debug messages from this at
the bottom. Once, I can pair a node and a coordinator, I'd like to
send/receive messages between them from userland code (even broadcast
messages will do for now!). Is it too optimistic yet? Or has it been
done already? If it is already supported, even the simplest of code
samples will save me a lot of time! :)

Thanks!
-Rohit

root@raspberrypi:~#  iwpan --debug phy wpan-phy1 interface add wpan2
type coordinator 00:00:00:00:00:00:00:11
-- Debug: Sent Message:
--------------------------   BEGIN NETLINK MESSAGE ---------------------------
  [HEADER] 16 octets
    .nlmsg_len = 60
    .nlmsg_type = 21 <0x15>
    .nlmsg_flags = 5 <REQUEST,ACK>
    .nlmsg_seq = 1420839332
    .nlmsg_pid = 2492
  [PAYLOAD] 44 octets
    07 00 00 00 08 00 01 00 01 00 00 00 0a 00 04 00 77 70 ................wp
    61 6e 32 00 00 00 08 00 05 00 02 00 00 00 0c 00 17 00 an2...............
    11 00 00 00 00 00 00 00                               ........
---------------------------  END NETLINK MESSAGE   ---------------------------
-- Debug: Received Message:
--------------------------   BEGIN NETLINK MESSAGE ---------------------------
  [HEADER] 16 octets
    .nlmsg_len = 80
    .nlmsg_type = 2 <ERROR>
    .nlmsg_flags = 0 <>
    .nlmsg_seq = 1420839332
    .nlmsg_pid = 2492
  [ERRORMSG] 20 octets
    .error = -22 "Invalid argument"
  [ORIGINAL MESSAGE] 16 octets
    .nlmsg_len = 16
    .nlmsg_type = 21 <0x15>
    .nlmsg_flags = 5 <REQUEST,ACK>
    .nlmsg_seq = 1420839332
    .nlmsg_pid = 2492
---------------------------  END NETLINK MESSAGE   ---------------------------
command failed: Invalid argument (-22)
root@raspberrypi:~#
