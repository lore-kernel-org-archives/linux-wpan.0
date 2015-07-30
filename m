Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33809 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbG3Wxa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Jul 2015 18:53:30 -0400
Received: by wibud3 with SMTP id ud3so37874520wib.1
        for <linux-wpan@vger.kernel.org>; Thu, 30 Jul 2015 15:53:29 -0700 (PDT)
Date: Fri, 31 Jul 2015 00:53:47 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 1/2] ieee802154: 6lowpan: remove multiple
 lowpan support
Message-ID: <20150730225347.GD1037@omega>
References: <1437742905-5921-1-git-send-email-alex.aring@gmail.com>
 <1437742905-5921-2-git-send-email-alex.aring@gmail.com>
 <55BA4D95.2000405@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55BA4D95.2000405@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Jul 30, 2015 at 06:15:17PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 24/07/15 15:01, Alexander Aring wrote:
> >We currently supports multiple lowpan interfaces per wpan interface. I
> >never saw any use case into such functionality. We drop this feature now
> >because it's much easier do deal with address changes inside the under
> >laying wpan interface.
> >
> >This patch removes the multiple lowpan interface and adds a lowpan_dev
> >netdev pointer into the wpan_dev, if this pointer isn't null the wpan
> >interface belongs to the assigned lowpan interface.
> >
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> 
> I did not come up with a use case for it and nobody complained for a week so
> it should be ok to be removed. If this brings trouble and we get a good use
> case we can always bring this back.
> 
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> 
> I also tested them on my setup without seeing any trouble. Do we collect
> Tested tags here or are we happy with reviewed tags? In case we collect them
> 
> Tested-by: Stefan Schmidt <stefan@osg.samsung.com>
> 

I am happy with both. :-)

- Alex
