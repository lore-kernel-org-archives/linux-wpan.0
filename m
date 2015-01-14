Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:46728 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbbANOQF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 14 Jan 2015 09:16:05 -0500
Received: by mail-wi0-f173.google.com with SMTP id hi2so5619786wib.0
        for <linux-wpan@vger.kernel.org>; Wed, 14 Jan 2015 06:16:04 -0800 (PST)
Received: from omega (p20030064A91100BCE2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a911:bc:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id eu8sm2923995wib.21.2015.01.14.06.16.03
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jan 2015 06:16:03 -0800 (PST)
Date: Wed, 14 Jan 2015 15:16:01 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 802.15.4 6LoWPAN fragmentation is broken
Message-ID: <20150114141600.GB19961@omega>
References: <20150113112016.GA14472@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150113112016.GA14472@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

On Tue, Jan 13, 2015 at 12:20:16PM +0100, Alexander Aring wrote:
> Hi,
> 
> I notice some issue with fragmentation code.
> 
> There is some magic number like:
> 
> ping6 2001::1 -s 2145
> 
> with a payload of 2144 it works. It seems that all payloads above
> 2144 are broken. I will try to bisect this issue. I see this issue also
> in net-next. I suppose it's something with the inet_frag API.
> 
> 
> ... so don't worry I already working on it.
> 

Status update to this:

I detected that systemd changed the default net scheduler to fq_codel. [0]
With fq_codel seems that 6LoWPAN fragmentation is broken.

For now: please don't use this scheduler. I will try to find out why we have
fragmentation issues with fq_codel.

- Alex

[0] http://cgit.freedesktop.org/systemd/systemd/commit/?id=e6c253e363dee77ef7e5c5f44c4ca55cded3fd47
