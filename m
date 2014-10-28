Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:49167 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429AbaJ1Vn5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 17:43:57 -0400
Message-ID: <54500E1B.20805@xsilon.com>
Date: Tue, 28 Oct 2014 21:43:55 +0000
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: skb free patches
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Alex,

I've prepared the patches for freeing skb outside of the decompress 
routines but now I'm unsure whether this is the best thing to do.

Plus side
it makes the decompression routine neater, no goto's, just return an 
error code.
Centralises the freeing of the skb.
Easier to maintain, future decompression routines don't have to worry 
about making sure all error paths have freed the skb.

Negative side
Decompression routines musn't reallocate the skb, ie make a copy. The 
skb pointer that is passed in must still be valid on return otherwise we 
get a double free.  I think skb_cow is ok as it calls pskb_expand_head 
which just makes more room in the data but if a routine was to use 
skb_copy then I think we would be in trouble.

Maybe decompression routines should only be using routines like skb_cow 
as they are more effecient.  What are your thoughts before I send the 
series?


- Martin.
