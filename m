Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33862 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934161AbaLLPJC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 10:09:02 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so9358285wgh.34
        for <linux-wpan@vger.kernel.org>; Fri, 12 Dec 2014 07:09:00 -0800 (PST)
Date: Fri, 12 Dec 2014 16:08:48 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] at86rf230: remove version check for AT86RF212
Message-ID: <20141212150845.GA28137@omega>
References: <1418339480-26681-1-git-send-email-andrey@snupi.com>
 <243a01d015e8$bb7cf930$3276eb90$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <243a01d015e8$bb7cf930$3276eb90$@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <s.schmidt@samsung.com>
Cc: 'Andrey Yurovsky' <andrey@snupi.com>, linux-wpan@vger.kernel.org, 'Andrey Yurovsky' <yurovsky@gmail.com>

On Fri, Dec 12, 2014 at 08:50:50AM +0000, Stefan Schmidt wrote:
> Hello.
> 
> On 12/12/14 00:11, Andrey Yurovsky wrote:
> >From: Andrey Yurovsky <yurovsky@gmail.com>
> >
> >This version check allows the driver to only work with v1 hardware
> >however there is no driver-facing difference with newer versions
> >(confirmed by Atmel FAEs) so this check needlessly prevents the driver
> >from being used with radios now in production.
> 
> Has anyone tested the driver with this new hardware yet? Or are the
> productions so early that there are now samples yet?
> 

It's okay I know Andrey version mismatch battle a long time ago and he
used one of the transceivers so I suppose he also tested it.

- Alex
