Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:56567 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbaJTKGi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Oct 2014 06:06:38 -0400
Message-ID: <5444DEAA.60307@xsilon.com>
Date: Mon, 20 Oct 2014 11:06:34 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 0/5] Move skb delivery out of IPHC.
References: <1413616153-7562-1-git-send-email-mtownsend1973@gmail.com> <20141020072520.GA5404@omega> <5444C90D.9020402@xsilon.com> <20141020085555.GB5404@omega> <5444CF99.4080305@xsilon.com> <20141020091043.GC5404@omega>
In-Reply-To: <20141020091043.GC5404@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com

Hi Alex,

I think if I put the skb free stuff in lowpan_give_skb_to_devices then it should all be fixed.

- lowpan_process_data or now lowpan_header_decompress will either
     - always free the skb on error and return an error code
     - or return 0.  So there is no chance of NET_RX_FOO codes being returned as we have moved skb deilvery out of this path.

- This means that lowpan_recv can now checks to see if ret < 0, I could change this to ret != 0 if you want but the outcome is the same, if decompression fails then skb has been freed so goto drop.

- This leaves the last part lowpan_give_skb_to_devices must now free or consume the skb (which I've just added).

Hopefully this sorts out the original problem? or have I missed something.

My next patch series will remove all the kfree_skb's from decompression but I don't think this fixes anything just makes the code more maintainable in that we don't have to worry about making sure all error paths are covered.

Let me know what you think and then I'll send v2.

- Martin.



On 20/10/14 10:10, Alexander Aring wrote:
> On Mon, Oct 20, 2014 at 10:02:17AM +0100, Martin Townsend wrote:
>> Hi Alex,
>>
>> I've completely forgotten what the original problem was it was so long ago :)  , let me dig through the old emails and see if I can jog my memory. 
>>
>> My intention was to do the kfree_skb patch in my next submission but I'll see what I can do.
>>
> yea, the problem a general error handling issue in mainly two parts:
>
>  - detection errors. Means the NET_RX_FOO conversion to errno. But you
>    put out the netif_rx call outside of lowpan_header_create which is
>    very well. I approve that one. Now it's important that the "lowpan
>    give to upper layer" functions not returning ERRNO's and NET_RX_FOO.
>
>    Again, errno is a negative value and NET_RX_FOO is 0 or 1. We can't
>    check on a error with if (ret < 0) or (ret == NET_RX_DROP). Also
>    (ret != NET_RX_SUCCESS) will not work because it's "1" and "0"
>    indicate successful or sometimes not successful because NET_RX_DROP
>    was returned and this is "0". Lot of confusing here.
>
>    For the "lowpan give to upper layer" functions doesn't matter if
>    errno is returned or NET_RX_FOO, but don't a mix of both!
>    The "lowpan_header_create" should return errno's.
>
>  - Second issue was a complete wrong reaction on error handling and
>    memory managment with "kfree_skb" which needs a fix of the above one
>    at first to introduce a correct error handling.
>
>
> Now I see a little bit the fix of the first one. But not the second one.
> Or should these things all fine now, otherwise I will take a more
> careful review.
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

