Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34585 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdFZEFS (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 26 Jun 2017 00:05:18 -0400
Subject: Re: [PATCH net-next v2 5/5] net: add netlink_ext_ack argument to
 rtnl_link_ops.slave_validate
References: <cover.1498425679.git.mschiffer@universe-factory.net>
 <ae78184571760c3430159ea5a654e3d08ba2479d.1498425679.git.mschiffer@universe-factory.net>
From: David Ahern <dsahern@gmail.com>
Message-ID: <2a529345-ab92-aa14-7f1e-f8af3a9026eb@gmail.com>
Date: Sun, 25 Jun 2017 22:05:15 -0600
MIME-Version: 1.0
In-Reply-To: <ae78184571760c3430159ea5a654e3d08ba2479d.1498425679.git.mschiffer@universe-factory.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Matthias Schiffer <mschiffer@universe-factory.net>, dledford@redhat.com, sean.hefty@intel.com, hal.rosenstock@gmail.com, j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, wg@grandegger.com, mkl@pengutronix.de, pablo@netfilter.org, laforge@gnumonks.org, paulus@samba.org, jiri@resnulli.us, dsa@cumulusnetworks.com, shm@cumulusnetworks.com, davem@davemloft.net, stephen@networkplumber.org, arvid.brodin@alten.se, alex.aring@gmail.com, stefan@osg.samsung.com, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@trash.net, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, johannes@sipsolutions.net
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, linux-ppp@vger.kernel.org, linux-wpan@vger.kernel.org

On 6/25/17 3:56 PM, Matthias Schiffer wrote:
> Add support for extended error reporting.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---

Acked-by: David Ahern <dsahern@gmail.com>
