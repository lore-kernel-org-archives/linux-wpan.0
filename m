Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from chaos.universe-factory.net ([31.24.148.19]:42740 "EHLO
        chaos.universe-factory.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751349AbdFYV4M (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 25 Jun 2017 17:56:12 -0400
From: Matthias Schiffer <mschiffer@universe-factory.net>
Subject: [PATCH net-next v2 0/5] net: add netlink_ext_ack support to rtnl_link_ops
Date: Sun, 25 Jun 2017 23:55:58 +0200
Message-Id: <cover.1498425679.git.mschiffer@universe-factory.net>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: dledford@redhat.com, sean.hefty@intel.com, hal.rosenstock@gmail.com, j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, wg@grandegger.com, mkl@pengutronix.de, pablo@netfilter.org, laforge@gnumonks.org, paulus@samba.org, jiri@resnulli.us, dsa@cumulusnetworks.com, shm@cumulusnetworks.com, davem@davemloft.net, stephen@networkplumber.org, arvid.brodin@alten.se, alex.aring@gmail.com, stefan@osg.samsung.com, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@trash.net, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, johannes@sipsolutions.net
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, linux-ppp@vger.kernel.org, linux-wpan@vger.kernel.org

Same changes as http://patchwork.ozlabs.org/patch/780351/ , split into
separate patches for each rtnl_link_ops field as requested.


Matthias Schiffer (5):
  net: add netlink_ext_ack argument to rtnl_link_ops.newlink
  net: add netlink_ext_ack argument to rtnl_link_ops.changelink
  net: add netlink_ext_ack argument to rtnl_link_ops.validate
  net: add netlink_ext_ack argument to rtnl_link_ops.slave_changelink
  net: add netlink_ext_ack argument to rtnl_link_ops.slave_validate

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c | 10 ++++++----
 drivers/net/bonding/bond_netlink.c           | 16 ++++++++++------
 drivers/net/caif/caif_hsi.c                  |  6 ++++--
 drivers/net/can/dev.c                        | 11 +++++++----
 drivers/net/can/vxcan.c                      |  3 ++-
 drivers/net/dummy.c                          |  3 ++-
 drivers/net/geneve.c                         |  6 ++++--
 drivers/net/gtp.c                            |  6 ++++--
 drivers/net/ifb.c                            |  3 ++-
 drivers/net/ipvlan/ipvlan.h                  |  3 ++-
 drivers/net/ipvlan/ipvlan_main.c             |  9 ++++++---
 drivers/net/ipvlan/ipvtap.c                  |  9 ++++-----
 drivers/net/macsec.c                         |  9 ++++++---
 drivers/net/macvlan.c                        |  9 ++++++---
 drivers/net/macvtap.c                        |  7 +++----
 drivers/net/nlmon.c                          |  3 ++-
 drivers/net/ppp/ppp_generic.c                |  6 ++++--
 drivers/net/team/team.c                      |  6 ++++--
 drivers/net/tun.c                            |  3 ++-
 drivers/net/veth.c                           |  8 +++++---
 drivers/net/vrf.c                            |  6 ++++--
 drivers/net/vxlan.c                          |  9 ++++++---
 include/net/rtnetlink.h                      | 15 ++++++++++-----
 net/8021q/vlan_netlink.c                     | 13 ++++++++-----
 net/bridge/br_netlink.c                      | 15 ++++++++++-----
 net/caif/chnl_net.c                          |  6 ++++--
 net/core/rtnetlink.c                         | 13 ++++++++-----
 net/hsr/hsr_netlink.c                        |  3 ++-
 net/ieee802154/6lowpan/core.c                |  6 ++++--
 net/ipv4/ip_gre.c                            | 16 ++++++++++------
 net/ipv4/ip_vti.c                            |  9 ++++++---
 net/ipv4/ipip.c                              |  9 ++++++---
 net/ipv6/ip6_gre.c                           | 14 +++++++++-----
 net/ipv6/ip6_tunnel.c                        |  9 ++++++---
 net/ipv6/ip6_vti.c                           |  9 ++++++---
 net/ipv6/sit.c                               |  9 ++++++---
 36 files changed, 190 insertions(+), 107 deletions(-)

-- 
2.13.1

