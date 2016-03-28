Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:35426 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbcC1PqG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 28 Mar 2016 11:46:06 -0400
Received: by mail-io0-f174.google.com with SMTP id g185so25276544ioa.2
        for <linux-wpan@vger.kernel.org>; Mon, 28 Mar 2016 08:46:05 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 28 Mar 2016 22:46:04 +0700
Message-ID: <CALqexQVqxwfKxZ=fmtjQPnHcdibVFmFTG4dRZkBwC4aJfLkE5A@mail.gmail.com>
Subject: No device found for binding socket ieee802.15.4
From: Adika Bintang Sulaeman <adikabintang78@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Dear all linux-wpan developers and users,

This is my first time exploring 6LoWPAN and I would like to ask you
some questions. Before getting into questions, these are the devices
and set up that I use:
-Raspberry Pi Model B Rev 2
-Raspbian OS
-kernel from bluetooth-next ver 4.5.0-rc5+
-MRF24J40MA Transceiver

After setting up and installing the wpan-tools, I got my interface
work by prompting "ip link show" and there is something like:

3: wpan0 <BROADCAST,NOARP> mtu 123 qdisc noop state DOWN mode DEFAULT
group default qlen 1000
        link/ieee802.15.4 ee:3b:07:84:64:8c:2a:71 brd ff:ff:ff:ff:ff:ff:ff

The first thing I notice strange is why after the command "sudo ip
link add link wpan0 name lowpan0 type lowpan" the output in "ip link
show" is a bit different, especially in link/[825]:

7: lowpan0 <BROADCAST,MULTICAST> mtu 1280 qdisc noop state DOWN mode
DEFAULT group default qlen 1
        link/[825] ee:3b:07:84:64:8c:2a:71 brd ff:ff:ff:ff:ff:ff:ff

So this is the FIRST QUESTION:
1. Is that normal/ok to have link/[825] instead of link/ieee802.15.4?

The second thing I notice strange is after "sudo ip link set wpan0 up"
for both wpan0 and lowpan0, the "ifconfig" command shows that these
network interfaces have "Link encap:UNSPEC". If I'm not mistaken, Link
encap shows the hardware family of the interface, right?

So the SECOND QUESTION is:
2. Is that normal/ok to have Link encap:UNSPEC? Because this thing
makes me suspicious about the next problem that I face.

I tried to run wpan-ping daemon from /wpan-tools/wpan-ping by
prompting "wpan-ping --daemon" but the output is "bind: No such
device". I tried to make my own code to make a server program which
listen to this socket interface. But when binding with bind(), I got
the same error status "No device found".

This leads to my THIRD QUESTION:
3. Why "no device found" appears? The transceiver is attached, the
hardware address exists, the interface is up, and I am able to ping
between two devices using ping6. I am suspicious that the problems
that I ask you before have caused this problem.

Do you know what's wrong here?

Thank you for your time and help
