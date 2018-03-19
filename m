Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-he1eur01on0113.outbound.protection.outlook.com ([104.47.0.113]:28891
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755350AbeCSLpg (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 19 Mar 2018 07:45:36 -0400
Subject: [PATCH net-next 0/2] Converting pernet_operations (part #10)
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Date: Mon, 19 Mar 2018 14:45:28 +0300
Message-ID: <152145973147.26348.4080298027358158796.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com, stefan@osg.samsung.com, davem@davemloft.net, pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de, yoshfuji@linux-ipv6.org, brouer@redhat.com, keescook@chromium.org, ktkhai@virtuozzo.com, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org

Hi,

this series continues to review and to convert pernet_operations
to make them possible to be executed in parallel for several
net namespaces at the same time. There are two ops similar
to already converted ip4_frags_ops.

This requires a560002437d3 "net: Fix hlist corruptions
in inet_evict_bucket()", which is currently in net.git.

It seems to be the finial convertion series.

Thanks,
Kirill
---

Kirill Tkhai (2):
      net: Convert lowpan_frags_ops
      net: Convert nf_ct_net_ops


 net/ieee802154/6lowpan/reassembly.c     |    1 +
 net/ipv6/netfilter/nf_conntrack_reasm.c |    1 +
 2 files changed, 2 insertions(+)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
