Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:60628 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeHJNdE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 10 Aug 2018 09:33:04 -0400
Date: Fri, 10 Aug 2018 14:03:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ieee802154: hwsim: add replacement for fakelb
Message-ID: <20180810110328.hkv5ktvp2hlxb6z4@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: aring@mojatatu.com
Cc: linux-wpan@vger.kernel.org

Hello Alexander Aring,

The patch f25da51fdc38: "ieee802154: hwsim: add replacement for
fakelb" from Jul 14, 2018, leads to the following static checker
warning:

	drivers/net/ieee802154/mac802154_hwsim.c:739 hwsim_subscribe_all_others()
	error: we previously assumed 'e' could be null (see line 721)

drivers/net/ieee802154/mac802154_hwsim.c
   714  static int hwsim_subscribe_all_others(struct hwsim_phy *phy)
   715  {
   716          struct hwsim_phy *sub;
   717          struct hwsim_edge *e;
   718  
   719          list_for_each_entry(sub, &hwsim_phys, list) {
   720                  e = hwsim_alloc_edge(sub, 0xff);
   721                  if (!e)
   722                          goto me_fail;
                                ^^^^^^^^^^^^
   723  
   724                  list_add_rcu(&e->list, &phy->edges);
   725          }
   726  
   727          list_for_each_entry(sub, &hwsim_phys, list) {
   728                  e = hwsim_alloc_edge(phy, 0xff);
   729                  if (!e)
   730                          goto sub_fail;
   731  
   732                  list_add_rcu(&e->list, &sub->edges);
   733          }
   734  
   735          return 0;
   736  
   737  me_fail:
   738          list_for_each_entry(phy, &hwsim_phys, list) {
   739                  list_del_rcu(&e->list);
   740                  hwsim_free_edge(e);

"e" is NULL.  Also we're in a loop so it's a double free.  You probably
want to use list_for_each_entry_safe() when we call list_del() and free.

   741          }
   742  sub_fail:
   743          hwsim_edge_unsubscribe_me(phy);
                                          ^^^
Then careful here.

   744          return -ENOMEM;
   745  }

regards,
dan carpenter
