Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35115 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758394AbcDHM6Y (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 Apr 2016 08:58:24 -0400
Received: by mail-wm0-f42.google.com with SMTP id 191so17509369wmq.0
        for <linux-wpan@vger.kernel.org>; Fri, 08 Apr 2016 05:58:23 -0700 (PDT)
Date: Fri, 8 Apr 2016 14:58:07 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: UDP stress-testing
Message-ID: <20160408125805.GA2021@omega>
References: <5706C0D7.1040000@haw-hamburg.de>
 <20160407204125.GA4736@omega>
 <57075C35.5070206@haw-hamburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57075C35.5070206@haw-hamburg.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Peter Kietzmann <peter.kietzmann@haw-hamburg.de>
Cc: linux-wpan@vger.kernel.org

On Fri, Apr 08, 2016 at 09:22:29AM +0200, Peter Kietzmann wrote:
...
> >
> >3.
> >
> >Change tx queue setting:
> >
> >ip link set txqueuelen 1000 dev $WPAN_DEV
> 
> That was the parameter I was looking for. Increasing this queue it is :-) !
> 

Maybe we should increase the default parameter for the txqueuelen. I
know there is some science about to calculate bandwidth, payload, etc to
calculate a good value.

I know ethernet changed to 1000 because gigabit ethernet is common
nowadays, before it was 100.

Our default value is 300 (don't know why, Alan increased it one day), see
commit e937f583ec3a40cccd480b40d8c6d54751781587.

It was 10 before and 10 is really too small...

- Alex
