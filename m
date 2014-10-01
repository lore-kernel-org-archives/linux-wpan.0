Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:36737 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbaJAAiU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Sep 2014 20:38:20 -0400
Received: by mail-wg0-f48.google.com with SMTP id l18so115585wgh.19
        for <linux-wpan@vger.kernel.org>; Tue, 30 Sep 2014 17:38:19 -0700 (PDT)
Date: Wed, 1 Oct 2014 02:38:16 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Problems with fakeserial
Message-ID: <20141001003814.GB1007@omega>
References: <542ACF52.3030807@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <542ACF52.3030807@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi Martin,

first, the serial things came never into mainline. I like the idea to
abstract a serial protocol above the 802.15.4 layer which run as
firmware on several devices. But the serial driver never came into mainline.

On Tue, Sep 30, 2014 at 04:42:10PM +0100, Martin Townsend wrote:
> Hi,
> 
> I'm trying to use the virtual-ieee802154-serial code but when I use izattach I get the following error msg:
> 
> root@10:/etc/init.d# izattach /dev/fakeserial0
> ioctl: TIOCSETD: Invalid argument
> 

Do you ported and loaded the serial driver module? I also need to say
that I never tested the serial driver or virtual-ieee802154-serial
stuff. Maybe simple original author Tony Cheneau [0]. Maybe he has time
to help here a little bit.

> I've tried ensuring the baud rates match and still get the same error.
> 
> I'm using the following git repos for the userspace tools, is this still correct?
> git://git.code.sf.net/p/linux-zigbee/linux-zigbee
> 

Yes, sad but should be correct.

- Alex

[0] tony.cheneau@amnesiak.org
