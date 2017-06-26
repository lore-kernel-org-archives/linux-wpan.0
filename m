Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35711 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdFZNre (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 26 Jun 2017 09:47:34 -0400
Subject: Re: [PATCH net-next v2 4/5] net: add netlink_ext_ack argument to
 rtnl_link_ops.slave_changelink
References: <cover.1498425679.git.mschiffer@universe-factory.net>
 <498ff06f59d5ce13b2ad3e1c1902c3d348ca3c00.1498425679.git.mschiffer@universe-factory.net>
 <b097a69e-4449-b124-c39e-4dbdbae7c218@gmail.com>
 <dd3f596b-4519-398c-a2ec-afdaf5f2f058@gmail.com>
 <15d2138d-5026-a35b-8a3c-2a88d05df688@universe-factory.net>
 <27b8d607-7442-0a42-1389-9548840445dc@gmail.com>
 <bb1892a4-2227-cdc4-e017-f39f133fd20a@universe-factory.net>
From: David Ahern <dsahern@gmail.com>
Message-ID: <2347cfcf-efe0-d2b7-56c9-5dbd556eee51@gmail.com>
Date: Mon, 26 Jun 2017 07:47:31 -0600
MIME-Version: 1.0
In-Reply-To: <bb1892a4-2227-cdc4-e017-f39f133fd20a@universe-factory.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Matthias Schiffer <mschiffer@universe-factory.net>, dledford@redhat.com, sean.hefty@intel.com, hal.rosenstock@gmail.com, j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, wg@grandegger.com, mkl@pengutronix.de, pablo@netfilter.org, laforge@gnumonks.org, paulus@samba.org, jiri@resnulli.us, dsa@cumulusnetworks.com, shm@cumulusnetworks.com, davem@davemloft.net, stephen@networkplumber.org, arvid.brodin@alten.se, alex.aring@gmail.com, stefan@osg.samsung.com, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@trash.net, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, johannes@sipsolutions.net
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, linux-ppp@vger.kernel.org, linux-wpan@vger.kernel.org

On 6/26/17 7:45 AM, Matthias Schiffer wrote:
> 
> Please read my patch again, I *am* changing br_port_slave_changelink to
> match the new signature (this is the net/bridge/br_netlink.c change
> appearing in the diffstat).
> 

Hmmm.... right you are. sorry for the confusion.
