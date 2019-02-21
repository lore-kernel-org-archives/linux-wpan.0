Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it1-f193.google.com ([209.85.166.193]:51534 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfBUPb3 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 21 Feb 2019 10:31:29 -0500
Received: by mail-it1-f193.google.com with SMTP id e24so9263037itl.1
        for <linux-wpan@vger.kernel.org>; Thu, 21 Feb 2019 07:31:28 -0800 (PST)
Date: Thu, 21 Feb 2019 10:31:23 -0500
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: Running OpenThread on fakelb
Message-ID: <20190221153123.jao2k2baqmd4eb45@x220t>
References: <dec2e8f279a14dc0b29dd92707e83319@exch1-mel.nexus.csiro.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dec2e8f279a14dc0b29dd92707e83319@exch1-mel.nexus.csiro.au>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Seung.Jang@data61.csiro.au
Cc: linux-wpan@vger.kernel.org

Hi,

On Thu, Feb 21, 2019 at 12:31:19AM +0000, Seung.Jang@data61.csiro.au wrote:
> Hi all,
> 
> I'm trying to run OpenThread on fakelb, and I'd like to ask about this topic.
> 
> My test environment is Ubuntu 16.04 (kernel version 4.15).
> 
> I followed the instruction in Alex's announcement [1]. From one of ot-cli, I was able to ping the other ot-cli. At the same time, I tried to sniff packets of lowpan0, ot0, ot1, and monitor0 with wireshark. But wireshark detected nothing. When I compiled the ot-cli, I applied '--enable-af-packet'.
> 

The branch of openthread is somehow outdated, feel free to rebase to
openthread/master and send it upstream to openthread.

Your problem:

As I understand you can talk between openthread nodes but not with an
additional Linux 6lowpan interface. To make it capable with openthread
you need to use protocols which are from the Thread world. They have a
"somehow" closed bootstrapping protocol which is MLE. Also note they
forked the IETF MLE standard, so Thread MLE != IETF MLE.

I can give you more information what MLE exactly is if you want.

> Do you have any idea about this? Could you share any experience regarding this?
> 

How you can get Thread MLE working for you?

Good solution is:

"Use open implementation OpenThread and make a library wrapper around
 which is a MLE Linux userspace implementation. It should work on IPv6
 sockets and not AF_PACKET"

Hack solution is:

"Run openthread on node interfaces and AF_PACKET and keep mac settings
in sync" - not sure how this can work, I think it will only make more
trouble.

Another solution:

Just use af802154 in openthread, but then you only use Linux 802.15.4
drivers and mostly no upper layer protocol. Also on node interfaces you
need to keep address settings in sync which I didn't implemented.
On the other hand monitors has limitations when running in promiscuous
mode.

- Alex
