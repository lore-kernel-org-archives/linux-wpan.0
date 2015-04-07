Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33497 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbbDGNOV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Apr 2015 09:14:21 -0400
Received: by wgin8 with SMTP id n8so55638519wgi.0
        for <linux-wpan@vger.kernel.org>; Tue, 07 Apr 2015 06:14:20 -0700 (PDT)
Date: Tue, 7 Apr 2015 15:14:18 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv3 bluetooth-next 2/4] nl802154: add set interface cmd
Message-ID: <20150407131413.GC16415@omega>
References: <1428407393-16005-1-git-send-email-alex.aring@gmail.com>
 <1428407393-16005-3-git-send-email-alex.aring@gmail.com>
 <20150407135902.2b885270@zoidberg>
 <20150407122149.GA16415@omega>
 <5523CD93.6090102@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5523CD93.6090102@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>, linux-wpan@vger.kernel.org, kernel@pengutronix.de, mkl@pengutronix.de

Hi Varka,

On Tue, Apr 07, 2015 at 05:59:07PM +0530, Varka Bhadram wrote:
> On 04/07/2015 05:51 PM, Alexander Aring wrote:
...
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Instead of this its better to leave the current behavior as it is.
> 
> Why do we need to complicate the process...?

I think more this is easier for userspace application which need to call
one CMD_SET for dev or phy only, but yes... it's much complicated to
handle error handling then. The most error codes would be -EINVAL and
-ENOTSUPP and we should forget some error codes which comming from
spi_sync/spi_async calls, these are very unlikely.

To handle the -EINVAL and -ENOTSUPP error we need more stuff to check if
the phy supports that value. I will try to introduce at first such
behaviour, then we can reconsider if we need something like that or not.

- Alex
