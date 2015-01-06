Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:58675 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbbAFTS0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 6 Jan 2015 14:18:26 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so6009992wiv.12
        for <linux-wpan@vger.kernel.org>; Tue, 06 Jan 2015 11:18:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141211163116.GA21527@omega>
References: <20141207150814.GA9532@omega>
	<548487CF.4060009@fid4.com>
	<20141207171311.GB9532@omega>
	<20141207171903.GC9532@omega>
	<5484C900.2020402@fid4.com>
	<20141207215452.GB20260@omega>
	<5489B215.20707@fid4.com>
	<20141211163116.GA21527@omega>
Date: Tue, 6 Jan 2015 20:18:25 +0100
Message-ID: <CAFUtXGwgjGRikSS3tkzb++A9RCP4vgez2JQQLzbAGxLK06d6Hw@mail.gmail.com>
Subject: Re: [ANNOUNCE] wpan-tools 0.3 released
From: Maciej Wasilak <wasilak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: "Michael C. Cambria" <mcc@fid4.com>, linux-wpan@vger.kernel.org

Hello,

2014-12-11 17:31 GMT+01:00 Alexander Aring <alex.aring@gmail.com>:
> No, please forget the complete tutorial with iz.
>
> You need to set a pan_id. "iwpan dev wpan0 set pan_id 0xbeef" or something else
> Then create a lowpan interface with:
>
> ip link add link wpan0 name lowpan0 type lowpan
>
> lowpan0 is now your ipv6 interface which use 6LoWPAN.

I tried to follow instructions above and I have trouble changing
pan_id. When I execute command:
    sudo iwpan --debug dev wpan0 set pan_id 0xabcd
I get following output:

-- Debug: Sent Message:
--------------------------   BEGIN NETLINK MESSAGE ---------------------------
  [NETLINK HEADER] 16 octets
    .nlmsg_len = 36
    .type = 21 <0x15>
    .flags = 5 <REQUEST,ACK>
    .seq = 1420571541
    .port = -1023407865
  [GENERIC NETLINK HEADER] 4 octets
    .cmd = 10
    .version = 0
    .unused = 0
  [PAYLOAD] 16 octets
    08 00 03 00 02 00 00 00 06 00 09 00 cd ab 00 00 ................
---------------------------  END NETLINK MESSAGE   ---------------------------
-- Debug: Received Message:
--------------------------   BEGIN NETLINK MESSAGE ---------------------------
  [NETLINK HEADER] 16 octets
    .nlmsg_len = 56
    .type = 2 <ERROR>
    .flags = 0 <>
    .seq = 1420571541
    .port = -1023407865
  [ERRORMSG] 20 octets
    .error = -16 "Device or resource busy"
  [ORIGINAL MESSAGE] 16 octets
    .nlmsg_len = 16
    .type = 21 <0x15>
    .flags = 5 <REQUEST,ACK>
    .seq = 1420571541
    .port = -1023407865
---------------------------  END NETLINK MESSAGE   ---------------------------
command failed: Device or resource busy (-16)

I am using Raspberry Pi with Raspbian, and bluetooth-next branch
kernel (cloned today). I am using 802.15.4 hardware from openlabs.
Physical interface is recognized correctly:
    pi@raspberrypi ~ $ iwpan phy
    wpan_phy wpan-phy0
    supported channels:
        page 0: 11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26
    current_page: 0
    current_channel: 26
    cca_mode: 1
    tx_power: 0
Network wpan0 interface is created automatically on startup:
    pi@raspberrypi ~ $ iwpan dev
    phy#0
        Interface wpan0
            ifindex 2
            wpan_dev 0x1
            extended_addr 0xf9045327f9757da8
            short_addr 0xffff
            pan_id 0xffff
            type node
            max_frame_retries -1
            min_be 3
            max_be 5
            max_csma_backoffs 4
            lbt 0


I can create lowpan interface without problems (sudo ip link add link
wpan0 name lowpan0 type lowpan). It sends valid 6LoWPAN packets (I use
external sniffer), but pan_id remains 0xffff.

When I use old linux-wpan-next branch and old lowpan-tools, problem
doesn't occur.

I tried to bring wpan0 interface down (sudo ifconfig wpan0 down), but
it doesn't help.

Does anyone have the same problem?

Best Regards
Maciej Wasilak
