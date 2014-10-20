Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:45610 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbaJTI4B (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Oct 2014 04:56:01 -0400
Date: Mon, 20 Oct 2014 10:55:57 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 0/5] Move skb delivery out of IPHC.
Message-ID: <20141020085555.GB5404@omega>
References: <1413616153-7562-1-git-send-email-mtownsend1973@gmail.com>
 <20141020072520.GA5404@omega>
 <5444C90D.9020402@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5444C90D.9020402@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com

Hi Martin,

On Mon, Oct 20, 2014 at 09:34:21AM +0100, Martin Townsend wrote:
> Hi Alex,
> 
> On 20/10/14 08:25, Alexander Aring wrote:
> > Hi Martin,
> >
> > I did a fast quick test and it's still working. I see now the conversion
> > from to errno, but you didn't change/fix the behaviour with kfree_skb. I
> > am pretty sure this is still broken with and without your patch.
> >
> > I know you want to make smaller patches but can you please add the
> > conversion simple to this patch series? What I see now is the change
> > from if (ret != NET_RX_FOO) to errno. This change the behaviour of
> > current somewhat working state. What I mean, it's okay to change that
> > but please in a serie which contains also fixes for the kfree_skb thing.
> Is this the kfree_skb in lowpan_give_skb_to_devices? I'll add it in.

mhh no, I thought you main goal was to move out the error handling of
lowpan_process_header function (don't know the new name, maybe it is
iphc_decompression).

- Alex
