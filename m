Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:51662 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbaKAJLA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 05:11:00 -0400
Received: by mail-wi0-f176.google.com with SMTP id h11so2992963wiw.9
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 02:10:57 -0700 (PDT)
Date: Sat, 1 Nov 2014 10:10:55 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: problems with udp header compression
Message-ID: <20141101091052.GB31204@omega>
References: <5452081F.5090706@xsilon.com>
 <5452107B.8010805@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5452107B.8010805@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi Simon,

On Thu, Oct 30, 2014 at 10:18:35AM +0000, Simon Vincent wrote:
> This appears to be because if you use a RAW socket with IPPROTO_RAW the ipv6
> stack passes it straight through and the skb transport_header,
> network_header offset are not set.
> 
> Putting the following at the top of compress_udp_header fixes the problem
> but I am not sure it is safe.
> if (skb->transport_header == skb->network_header){
>         skb_set_transport_header(skb,sizeof(struct ipv6hdr));
>     }
> 

I see, this could make trouble for IPV6 RAW sockets. Can you please send
a patch for this and cc linux-bluetooth and linux-wpan. Also add some
comment why we do this is here, because the RAW socket issue.

Or just send it as RFC (means replace the PATCH into RFC in the
subject). Then we can talk about a better solution if this isn't a
perfect solution.

Also remove the unnecessary brackets -> checkpatch should show an error
because this.

- Alex
