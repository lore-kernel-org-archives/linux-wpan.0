Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34648 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbcDCRJX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 3 Apr 2016 13:09:23 -0400
Received: by mail-ig0-f170.google.com with SMTP id sy18so59272683igc.1
        for <linux-wpan@vger.kernel.org>; Sun, 03 Apr 2016 10:09:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <56FC3E0D.7060604@osg.samsung.com>
References: <CALqexQVqxwfKxZ=fmtjQPnHcdibVFmFTG4dRZkBwC4aJfLkE5A@mail.gmail.com>
	<20160329083732.GA1114@omega>
	<CALqexQUhA-wTJow59_PkkbnmJz8UWxW2WoCdU=qYHYNQjyMVvQ@mail.gmail.com>
	<56FB8E7F.70106@osg.samsung.com>
	<CALqexQWw4QuPWxTDe8SdHxeOptq6TCf-O4Mq_UL-pDxqUz=h1A@mail.gmail.com>
	<56FC3A38.7030305@osg.samsung.com>
	<CALqexQV2z5wR3y8pUtWeF0eENyo3v6pdak6sm09g7LcPuQ+4cA@mail.gmail.com>
	<56FC3E0D.7060604@osg.samsung.com>
Date: Mon, 4 Apr 2016 00:09:22 +0700
Message-ID: <CALqexQWbd=fq3c9jS87R0_fbOMROEh8uxKavx+4yGf3VUsoj1w@mail.gmail.com>
Subject: Re: No device found for binding socket ieee802.15.4
From: Adika Bintang Sulaeman <adikabintang78@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com

> If you have no specific requirements for the 6LoWPAN part normal
> client/server code written for the Linux IPv6 socket API should work
> over the lowpan0 interface.

Hi Stefan,

I'm sorry if my question would be too stupid or shallow, I just want
to make sure because I'm really new to this.

I have run an example from [1] on client-server model using UDP and
IPv6. To run this example, on the client side I run the command:

"listener <IPv6 of another machine for lowpan interface>%lowpan0
the-payload-is-here"

According to [2], <IPv6 address>%<interface's name> notation means the
machine will try to communicate  to <IPv6 address> machine through the
<interface's name> interface. Hence, I basically have run
client/server program with Linux IPv6 over the lowpan0 interface.
Alexander Aring gave me a good presentation slide [3] and on page 12
it is clearly written that Linux still uses AF_INET6 for 6LoWPAN.

I just want to make sure whether my approach on making client-server
model over 6LoWPAN is right. I am not sure because I don't know
whether the IPv6 header is compressed using 6LoWPAN adaptation layer.

[1] http://beej.us/guide/bgnet/output/html/singlepage/bgnet.html#datagram
[2] http://veithen.github.io/2013/12/30/how-to-correctly-parse-ipv6-addresses.html
[3] http://www.netdevconf.org/1.1/proceedings/slides/aring-generic-6lowpan-branch.pdf

Best regards
