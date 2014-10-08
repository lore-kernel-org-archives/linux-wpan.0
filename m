Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26911 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754192AbaJHMNc (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 8 Oct 2014 08:13:32 -0400
Message-ID: <1412770375.2705.25.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Wed, 08 Oct 2014 15:12:55 +0300
In-Reply-To: <54351AF4.5060907@xsilon.com>
References: <1412696037-25111-1-git-send-email-martin.townsend@xsilon.com>
		 <1412696037-25111-2-git-send-email-martin.townsend@xsilon.com>
		 <543408B2.1070309@xsilon.com>
	 <1412763863.2705.22.camel@jrissane-mobl.ger.corp.intel.com>
	 <54351AF4.5060907@xsilon.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, alex.aring@gmail.com

Hi Martin,

On ke, 2014-10-08 at 12:07 +0100, Martin Townsend wrote:
> Hi Jukka,
> 
> And there's no oops when kmemleak is activated on a kernel without the patch?

Confirmed. Only with your patch I see the crash. Tried with v2 but I can
also try v3. No other changes in kernel code between working and
non-working kernel.


Cheers,
Jukka


