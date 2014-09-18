Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:39729 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbaIRIdI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 04:33:08 -0400
Received: by mail-we0-f169.google.com with SMTP id w61so509501wes.28
        for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 01:33:06 -0700 (PDT)
Date: Thu, 18 Sep 2014 10:33:01 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140918083259.GA3774@omega>
References: <0MXovv-1XrSix456F-00WrKR@mrelayeu.kundenserver.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0MXovv-1XrSix456F-00WrKR@mrelayeu.kundenserver.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Sep 18, 2014 at 08:46:55AM +0100, Simon Vincent wrote:
> I think what is happening is similar to your theory. The packets are getting sent to the 802.15.4 driver and the compress header function but as we have the raw socket recvmsg the packet is also sent internally to this socket. 
> This is because a raw socket receives all messages that are sent and received. 
> It does appear to be a complex problem. I just need to prove that this is what is happening by inserting more debug.
> 
mh, ok. Good to know that there is maybe such issue with the fakelb
driver and 6LoWPAN. Maybe there exists some netdev flag setting or
something else to avoid this.

You could describe this problem at netdev@vger.kernel.org and maybe the
guys knows a solution.

At the moment we use's some callbacks for replacing IPv6 with 6LoWPAN
header which was not made to make this there. This seems to be a global
architecture problem of the 6LoWPAN stack.

Or we need a another fakelb driver solution, I remember the tun/tap
interfaces which allow to send/recv packets from/to userspace. They need
to have similar issues when they have two interfaces and link-local
addresses. I don't know how they deal with that. This idea is just a shoot
into the dark. ;-)

- Alex
