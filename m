Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:65422 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbaIHJH3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Sep 2014 05:07:29 -0400
Received: by mail-la0-f52.google.com with SMTP id b8so5686534lan.11
        for <linux-wpan@vger.kernel.org>; Mon, 08 Sep 2014 02:07:27 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 8 Sep 2014 11:07:27 +0200
Message-ID: <CAMyBxbYwTSigRyFD+qvfW0RZHXBmdqWP9XCym3U1HKdqWooTxw@mail.gmail.com>
Subject: Serial-driver
From: =?UTF-8?Q?Thomas_K=C3=BChnel?= <kuehnelth@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

I own a RaspBee[1] Transceiver, that I wanted to use on the Raspberry
Pi. On the wiki I noticed the page about the serial driver[2] which
sounded promising. So I used the patch[3] with some small changes to
make it work with the current net-next kernel and wrote my own
firmware for the RaspBee[4]. The firmware uses the µRacoli library for
I/O and network communication, so it should also work on other devices
supported by the library.

So my actual question is, why is the serial driver not part of
net-next? Was it just never sent to the mailing list for review or are
there any problems that need to be fixed first?


Thanks,

Thomas

[1] http://www.dresden-elektronik.de/funktechnik/solutions/wireless-light-control/raspbee/?L=1
[2] http://linux-zigbee.sourceforge.net/cgi-bin/trac.cgi/wiki/SerialV1
[3] https://gist.github.com/jpizarrom/a07d833a124835e171c2
[4] https://github.com/kuehnelth/raspbee-linux802154
