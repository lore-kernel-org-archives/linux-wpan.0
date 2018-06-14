Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:37578 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754660AbeFNTM7 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 14 Jun 2018 15:12:59 -0400
Received: by mail-it0-f42.google.com with SMTP id l6-v6so10162645iti.2
        for <linux-wpan@vger.kernel.org>; Thu, 14 Jun 2018 12:12:59 -0700 (PDT)
Date: Thu, 14 Jun 2018 15:12:53 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: Problem using AF_PACKET with SOCK_RAW on ieee802514 devices
Message-ID: <20180614191253.eoazp527ygqwxamd@x220t>
References: <2998722.BvyPDujJB3@saab-desktop>
 <1740660.EcI1Ua05jM@saab-desktop>
 <20180614171301.23vjxsxyjnmnsh3c@x220t>
 <2267568.qQMlmFo6mk@saab-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2267568.qQMlmFo6mk@saab-desktop>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Josef Filzmaier <j.filzmaier@gmx.at>
Cc: linux-wpan@vger.kernel.org

On Thu, Jun 14, 2018 at 08:37:20PM +0200, Josef Filzmaier wrote:
> Hi!
> 
> > Also do you use RPi kernel? 
> 
> I first encountered this problem on arch linux (x86_64) with its current 
> stable kernel (4.16.13) using the ATUSB firmware. Then i encountered the same 
> problem on a raspberry pi using raspbian with a rf212 directly over the spi 
> interface. (Custom compiled kernel to debug, 4.16.14).
> 

Question would be what is "Custom compiled kernel" rpi kernel [0] or mainline [1].

[0] has at least some known bugs sometimes, people report them here
because they use raspbian, etc. which use [0].

- Alex

[0] https://github.com/raspberrypi/linux
[1] https://www.kernel.org/
