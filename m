Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:49012 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbcFUHcg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 21 Jun 2016 03:32:36 -0400
Date: Tue, 21 Jun 2016 10:31:30 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: 6lowpan: introduce 6lowpan-nd
Message-ID: <20160621073130.GA15560@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: aar@pengutronix.de
Cc: linux-wpan@vger.kernel.org

Hello Alexander Aring,

The patch bbe5f5cefe28: "6lowpan: introduce 6lowpan-nd" from Jun 15,
2016, leads to the following static checker warning:

	net/6lowpan/ndisc.c:139 lowpan_ndisc_opt_addr_space()
	error: double unlock 'read_lock:&neigh->lock'

net/6lowpan/ndisc.c
   116  static int lowpan_ndisc_opt_addr_space(const struct net_device *dev,
   117                                         u8 icmp6_type, struct neighbour *neigh,
   118                                         u8 *ha_buf, u8 **ha)
   119  {
   120          struct lowpan_802154_neigh *n;
   121          struct wpan_dev *wpan_dev;
   122          int addr_space = 0;
   123  
   124          if (!lowpan_is_ll(dev, LOWPAN_LLTYPE_IEEE802154))
   125                  return 0;
   126  
   127          switch (icmp6_type) {
   128          case NDISC_REDIRECT:
   129                  n = lowpan_802154_neigh(neighbour_priv(neigh));
   130  
   131                  read_lock_bh(&neigh->lock);
   132                  if (lowpan_802154_is_valid_src_short_addr(n->short_addr)) {
   133                          memcpy(ha_buf, &n->short_addr,
   134                                 IEEE802154_SHORT_ADDR_LEN);
   135                          read_unlock_bh(&neigh->lock);
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Unlock.

   136                          addr_space += __ndisc_opt_addr_space(IEEE802154_SHORT_ADDR_LEN, 0);
   137                          *ha = ha_buf;
   138                  }
   139                  read_unlock_bh(&neigh->lock);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Second unlock.

   140                  break;
   141          case NDISC_NEIGHBOUR_ADVERTISEMENT:
   142          case NDISC_NEIGHBOUR_SOLICITATION:
   143          case NDISC_ROUTER_SOLICITATION:

regards,
dan carpenter
