Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61625 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755526AbaJHNgD (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 8 Oct 2014 09:36:03 -0400
Message-ID: <1412775335.2705.31.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Wed, 08 Oct 2014 16:35:35 +0300
In-Reply-To: <54353387.3070007@xsilon.com>
References: <1412696037-25111-1-git-send-email-martin.townsend@xsilon.com>
			 <1412696037-25111-2-git-send-email-martin.townsend@xsilon.com>
			 <543408B2.1070309@xsilon.com>
		 <1412763863.2705.22.camel@jrissane-mobl.ger.corp.intel.com>
		 <54351AF4.5060907@xsilon.com>
	 <1412770375.2705.25.camel@jrissane-mobl.ger.corp.intel.com>
	 <54353387.3070007@xsilon.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, alex.aring@gmail.com

Hi Martin,

On ke, 2014-10-08 at 13:52 +0100, Martin Townsend wrote:
> Hi Jukka,
> 
> I've misunderstood the constraints on pskb_expand_head.   I don't suppose you could quickly try this patch it now uses skb_share_check to ensure  skb->users == 1 and then I've put back in the skb_clone code that I took out which I think is causing the problem:

Tried this one and did not see any errors so far. I will leave my test
to run for the night. Please send a v4 and I will try to review it
tomorrow.

Cheers,
Jukka


