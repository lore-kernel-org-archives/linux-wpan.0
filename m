Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:32949 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbbCRMIf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 18 Mar 2015 08:08:35 -0400
Received: by weop45 with SMTP id p45so30610527weo.0
        for <linux-wpan@vger.kernel.org>; Wed, 18 Mar 2015 05:08:34 -0700 (PDT)
Date: Wed, 18 Mar 2015 13:08:31 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 0/2] nl802154: implement new SET commands
Message-ID: <20150318120831.GC8079@omega>
References: <1426678822-26644-1-git-send-email-alex.aring@gmail.com>
 <550968A4.5050908@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <550968A4.5050908@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, mkl@pengutronix.de

Hi Varka,

On Wed, Mar 18, 2015 at 05:29:32PM +0530, Varka Bhadram wrote:
> Hi Alex,
> 
> On 03/18/2015 05:10 PM, Alexander Aring wrote:
> 
> >Hi,
> >
> >this patch-series implement the already existed SET commands of an interface
> >and a wpan-phy. Currently we have one CMD for each setting which was a mistake
> >by me to implement it in this way. So we aren't currently a "real" UAPI header
> >for nl802154 and it's still under development. I decide now to change to
> >implement these setting in this way now. Currently I let these commands in
> >coexistens with the old commands but _NOTE_ I will remove the other commands
> >from the nl802154 later.
> >
> >So please use the new commands. When these patches are mainline I also want to
> >release a new wpan-tools release which use this new interface. Then everybody
> >has some time to change to the new wpan-tools release. After this "time" I will
> 
> Its better to send the patches along with wpan-tools, so that we can do the testing..
> 

of course, I will do.

- Alex
