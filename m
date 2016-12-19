Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:39318 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752592AbcLSA1S (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 18 Dec 2016 19:27:18 -0500
From: "Wong, Joshua Weng Onn" <joshua.weng.onn.wong@intel.com>
Subject: RE: Bluetooth 6lowpan ping6 slab corruption
Date: Mon, 19 Dec 2016 00:27:14 +0000
Message-ID: <E3B98393E6037849B63EA428240A65135C42A6@PGSMSX103.gar.corp.intel.com>
References: <E3B98393E6037849B63EA428240A65135BC9D5@PGSMSX103.gar.corp.intel.com>
 <c70d7129-be2d-4764-6f09-1153192c49be@pengutronix.de>
 <E3B98393E6037849B63EA428240A65135BCA89@PGSMSX103.gar.corp.intel.com>
 <efdc1a54-7fdc-80b8-f46d-d663addae509@pengutronix.de>
In-Reply-To: <efdc1a54-7fdc-80b8-f46d-d663addae509@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: "alex.aring@gmail.com" <alex.aring@gmail.com>, "jukka.rissanen@linux.intel.com" <jukka.rissanen@linux.intel.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi Alex,

> Hi,
> 
> On 12/16/2016 09:18 AM, Wong, Joshua Weng Onn wrote:
> ...
> >
> > Thank you for informing me about this. Sorry as I was not aware of the newer
> patches that you submitted to mainline.
> > At the moment I am not able to upgrade the kernel to a recent version as the
> other teams in my department are using kernel version 4.1.27 and I have to
> follow it strictly.
> >
> > I just got an idea. Perhaps what I can do is backport the patches and apply
> them to this version of the kernel. I am not sure if it will work entirely. I'll discuss
> this with my lead first if he wants me to do this and let you know if I am pursuing
> this.
> >
> 
> You can backport it, yes... but please _please_ don't do it... bring it mainline and
> then backport it.
> 
> Tell that your lead as suggestion from me.
> 
> It makes no sense that you backporting it only for you. This thing need to be
> fixed upstream...
> 
> In my opinion, all people who backporting it will do work for nothing...
> The next guy/girl which wants to try that out runs again into such issues.
> 
> These patches was sending to bluetooth-next, now I am busy with other things
> and can work on it at end of April maybe... and I think only in my free-time. This
> patch-series just needs a little cleanup and send as PATCH...
> 
> - Alex

I've finally just learned how to add inline '>' characters to the previous email. Had to make some changes in my email settings.

Thank you very much for your reply.
Ok noted on that. My most sincere apologies as I am quite new to this and I am still trying to understand how open source works. Didn't realize that it will cause repetitive work for others.

I will discuss this with my technical lead and update you along the way.

Thank you.

Best regards,
Joshua
