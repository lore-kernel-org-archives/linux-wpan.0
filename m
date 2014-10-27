Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46686 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbaJ0MJd (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 27 Oct 2014 08:09:33 -0400
Message-ID: <1414411726.2705.204.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH v5 bluetooth-next 0/4] 6lowpan: Move skb delivery out of
 IPHC
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Mon, 27 Oct 2014 14:08:46 +0200
In-Reply-To: <20141027052237.GA21400@omega>
References: <1414075256-9448-1-git-send-email-martin.townsend@xsilon.com>
	 <20141027052237.GA21400@omega>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, Martin Townsend <martin.townsend@xsilon.com>

On ma, 2014-10-27 at 06:22 +0100, Alexander Aring wrote:
> On Thu, Oct 23, 2014 at 03:40:52PM +0100, Martin Townsend wrote:
> > This series moves skb delivery out of IPHC and into the receive routines of
> > both bluetooth and 802.15.4.  The reason is that we need to support more
> > (de)compression schemes in the future.  It also means that calling 
> > lowpan_process_data now only returns error codes or 0 for success so 
> > this has been cleaned up.  The final patch then renames occurences of
> > lowpan_process_data and process_data to something more meaningful.
> > 
> 
> Acked-by: Alexander Aring <alex.aring@gmail.com>
> 
> on the complete serie.
> 
> - Alex


Tested this with Bluetooth 6lowpan and everything works just fine so ack
also from me.

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka


