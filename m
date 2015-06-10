Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35531 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbbFJIav (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Jun 2015 04:30:51 -0400
Received: by pdbnf5 with SMTP id nf5so33058012pdb.2
        for <linux-wpan@vger.kernel.org>; Wed, 10 Jun 2015 01:30:51 -0700 (PDT)
Message-ID: <5577F5A0.9050100@gmail.com>
Date: Wed, 10 Jun 2015 14:00:24 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: nl802154 enum misspelled, just send patch?
References: <20150610082449.GA20831@arazu>
In-Reply-To: <20150610082449.GA20831@arazu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer@christofferholmstedt.se>, linux-wpan@vger.kernel.org

On 06/10/2015 01:54 PM, Christoffer Holmstedt wrote:

> Hi
> While working on the CCA improvements to wpan-tools I noticed that one of the
> enums has a value misspelled. As the header is not in UAPI yet I suggest we
> fix this.
>
> NL802154_CCA_UWB_MULTIPEXED is missing an l (ell) in multiplexed.
>
> The header file is included in wpan-tools repository and available in the
> kernel. Should I just send a patch for bluetooth-next and then the new header
> file is copied over to wpan-tools repository or what is the procedure here?
>
> I assume normal procedure for more "stable" user-space software is that the
> kernel header file(s) should not be included in the user-space tool but instead
> included and linked against the kernel headers (from running system or similiar
> source). At the moment the nl802154 header is included in wpan-tools to make it
> easier to build while developing.
>
> So, should I send a patch for both bluetooth-next and wpan-tools or just
> bluetooth-next?

Send patch for both trees .  :-)

-- 
Varka Bhadram

