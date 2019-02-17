Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:54329 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfBQXIt (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 17 Feb 2019 18:08:49 -0500
Received: by mail-it1-f195.google.com with SMTP id f10so13646385ita.4
        for <linux-wpan@vger.kernel.org>; Sun, 17 Feb 2019 15:08:48 -0800 (PST)
Date: Sun, 17 Feb 2019 18:08:40 -0500
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [PATCH RFC net-next] 6lowpan: use rbtree for IP frag queue
Message-ID: <20190217230840.finshiu6s54cer4f@x220t>
References: <20190215022953.128092-1-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190215022953.128092-1-posk@google.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Peter Oskolkov <posk@google.com>
Cc: David Miller <davem@davemloft.net>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, Peter Oskolkov <posk@posk.io>, stefan@datenfreihafen.org

Hi,

On Thu, Feb 14, 2019 at 06:29:53PM -0800, Peter Oskolkov wrote:
> This patch aligns IP defragmenation logic in 6lowpan with that
> of IPv4 and IPv6: see
> commit d4289fcc9b16 ("net: IP6 defrag: use rbtrees for IPv6 defrag")
> 
> Modifying ip_defrag selftest seemed like an overkill, as I suspect
> most kernel test setups do not have 6lowpan hwsim enabled. So I ran
> the following code/script manually:
> 
> 	insmod ./mac802154_hwsim.ko
> 
> 	iwpan dev wpan0 set pan_id 0xbeef
> 	ip link add link wpan0 name lowpan0 type lowpan
> 	ip link set wpan0 up
> 	ip link set lowpan0 up
> 
> 	iwpan dev wpan1 set pan_id 0xbeef
> 	ip netns add foo
> 	iwpan phy1 set netns name foo
> 	ip netns exec foo ip link add link wpan1 name lowpan1 type lowpan
> 	ip netns exec foo ip link set wpan1 up
> 	ip netns exec foo ip link set lowpan1 up
> 
> 	ip -6 addr add "fb01::1/128" nodad dev lowpan0
> 	ip -netns foo -6 addr add "fb02::1/128" nodad dev lowpan1
> 
> 	ip -6 route add "fb02::1/128" dev lowpan0
> 	ip -netns foo -6 route add "fb01::1/128" dev lowpan1
> 
> 	# then in term1:
> 	   ip netns exec foo bash
> 	   ./udp_stream -6
> 
> 	# in term2:
> 	    ./udp_stream -c -6 -H fb02::1
> 
> 	# pr_warn_once showed that the code changed by this patch
> 	# was invoked.
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>

Acked-by: Alexander Aring <aring@mojatatu.com>

I tested this series and the code looks a lot simpler. Thanks.

Stefan do you see any issues?

- Alex
