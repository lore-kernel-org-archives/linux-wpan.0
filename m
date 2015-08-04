Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36994 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbbHDSJP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Aug 2015 14:09:15 -0400
Received: by wibud3 with SMTP id ud3so34571903wib.0
        for <linux-wpan@vger.kernel.org>; Tue, 04 Aug 2015 11:09:14 -0700 (PDT)
Date: Tue, 4 Aug 2015 20:09:41 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFCv3 bluetooth-next 4/6] mac802154: change max_frame_retries
 behaviour
Message-ID: <20150804180940.GC22216@omega>
References: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
 <1438246542-17633-5-git-send-email-alex.aring@gmail.com>
 <55C0EB0E.2010005@osg.samsung.com>
 <20150804180009.GB22216@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150804180009.GB22216@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Tue, Aug 04, 2015 at 08:00:09PM +0200, Alexander Aring wrote:
> On Tue, Aug 04, 2015 at 06:40:46PM +0200, Stefan Schmidt wrote:
> > Hello.
> > 
> > On 30/07/15 10:55, Alexander Aring wrote:
> > >This patch changes the default min value of max_frame_retries to 0 and
> > >changes the max_frame_retries default value to 3 which is also 802.15.4
> > >default.
> > You mean min_frame_retries to 0 here?
> 
> No, you mixed "frame_retries" ranges with "frame_retries" value.
> 

I need to admit, the mib value in 802.15.4 is named "max_frame_retries".
But it is sounds bad to name the variables for the range to:

min_max_frame_retries and max_max_frame_retries

so for the range we drop the "max" here.

At min_be and max_be, we need to do that, because we have a "min":

min_minbe, max_minbe, min_maxbe, max_maxbe.

But for "max_frame_retries" there exists no "min_frame_retries" inside
the 802.15.4 mib. We have this at maxbe, minbe because it's a random
generated number for some range, "max_frame_retries" is a static value.

- Alex
