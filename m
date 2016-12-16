Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54705 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754990AbcLPJy1 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 16 Dec 2016 04:54:27 -0500
Subject: Re: Bluetooth 6lowpan ping6 slab corruption
References: <E3B98393E6037849B63EA428240A65135BC9D5@PGSMSX103.gar.corp.intel.com>
 <c70d7129-be2d-4764-6f09-1153192c49be@pengutronix.de>
 <E3B98393E6037849B63EA428240A65135BCA89@PGSMSX103.gar.corp.intel.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <efdc1a54-7fdc-80b8-f46d-d663addae509@pengutronix.de>
Date: Fri, 16 Dec 2016 10:54:21 +0100
MIME-Version: 1.0
In-Reply-To: <E3B98393E6037849B63EA428240A65135BCA89@PGSMSX103.gar.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Wong, Joshua Weng Onn" <joshua.weng.onn.wong@intel.com>
Cc: "alex.aring@gmail.com" <alex.aring@gmail.com>, "jukka.rissanen@linux.intel.com" <jukka.rissanen@linux.intel.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>


Hi,

On 12/16/2016 09:18 AM, Wong, Joshua Weng Onn wrote:
...
> 
> Thank you for informing me about this. Sorry as I was not aware of the newer patches that you submitted to mainline.
> At the moment I am not able to upgrade the kernel to a recent version as the other teams in my department are using kernel version 4.1.27 and I have to follow it strictly.
> 
> I just got an idea. Perhaps what I can do is backport the patches and apply them to this version of the kernel. I am not sure if it will work entirely. I'll discuss this with my lead first if he wants me to do this and let you know if I am pursuing this.
> 

You can backport it, yes... but please _please_ don't do it... bring it
mainline and then backport it.

Tell that your lead as suggestion from me.

It makes no sense that you backporting it only for you. This thing need
to be fixed upstream...

In my opinion, all people who backporting it will do work for nothing...
The next guy/girl which wants to try that out runs again into such
issues.

These patches was sending to bluetooth-next, now I am busy with other
things and can work on it at end of April maybe... and I think only in
my free-time. This patch-series just needs a little cleanup and send as
PATCH...

- Alex
