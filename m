Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:40319 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932569AbbAFTpE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 6 Jan 2015 14:45:04 -0500
Received: by mail-wi0-f171.google.com with SMTP id bs8so6048388wib.16
        for <linux-wpan@vger.kernel.org>; Tue, 06 Jan 2015 11:45:02 -0800 (PST)
Date: Tue, 6 Jan 2015 20:44:56 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [ANNOUNCE] wpan-tools 0.3 released
Message-ID: <20150106194453.GB10133@omega>
References: <20141207150814.GA9532@omega>
 <548487CF.4060009@fid4.com>
 <20141207171311.GB9532@omega>
 <20141207171903.GC9532@omega>
 <5484C900.2020402@fid4.com>
 <20141207215452.GB20260@omega>
 <5489B215.20707@fid4.com>
 <20141211163116.GA21527@omega>
 <CAFUtXGwgjGRikSS3tkzb++A9RCP4vgez2JQQLzbAGxLK06d6Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFUtXGwgjGRikSS3tkzb++A9RCP4vgez2JQQLzbAGxLK06d6Hw@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Maciej Wasilak <wasilak@gmail.com>
Cc: "Michael C. Cambria" <mcc@fid4.com>, linux-wpan@vger.kernel.org

Hi,

Hi,

On Tue, Jan 06, 2015 at 08:18:25PM +0100, Maciej Wasilak wrote:
...
> 
> I can create lowpan interface without problems (sudo ip link add link
> wpan0 name lowpan0 type lowpan). It sends valid 6LoWPAN packets (I use
> external sniffer), but pan_id remains 0xffff.
> 
> When I use old linux-wpan-next branch and old lowpan-tools, problem
> doesn't occur.
> 

Which wpan-tools version do you use? Can you please try the newest
version which can be found at [0].

I did some changes according the new nl802154 uapi header, means enum
structural changes. Sorry about that, I suppose that's your problem.

Can you please try to update your wpan-tools or simple use the actual
one at [1].

If this doesn't help I don't know why you have this issue. The ifdown of
your wpan interface should fix the -EBUSY issue.


btw:
We return -EBUSY because the address filter is set on an interface up,
while interface up it's not easy to deal address filtering changes, also
we can remove some hotpath locks because these values are readonly at
tx/rx paths. These locks are still there and will be removed later.

- Alex

[0] http://wpan.cakelab.org/releases/
[1] https://github.com/linux-wpan/wpan-tools
