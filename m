Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35131 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbdFYC7a (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 24 Jun 2017 22:59:30 -0400
Subject: Re: [PATCH net-next] net: add netlink_ext_ack support to
 rtnl_link_ops
References: <01256ebba091f2108ebeff43e61305bb533067d4.1498303258.git.mschiffer@universe-factory.net>
From: David Ahern <dsahern@gmail.com>
Message-ID: <1bfb7a80-a440-f960-1f35-a70542106cfb@gmail.com>
Date: Sat, 24 Jun 2017 20:50:24 -0600
MIME-Version: 1.0
In-Reply-To: <01256ebba091f2108ebeff43e61305bb533067d4.1498303258.git.mschiffer@universe-factory.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Matthias Schiffer <mschiffer@universe-factory.net>, dledford@redhat.com, sean.hefty@intel.com, hal.rosenstock@gmail.com, j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, dmitry.tarnyagin@lockless.no, wg@grandegger.com, mkl@pengutronix.de, pablo@netfilter.org, laforge@gnumonks.org, paulus@samba.org, jiri@resnulli.us, dsa@cumulusnetworks.com, shm@cumulusnetworks.com, davem@davemloft.net, stephen@networkplumber.org, arvid.brodin@alten.se, alex.aring@gmail.com, stefan@osg.samsung.com, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@trash.net, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, johannes@sipsolutions.net
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org, linux-ppp@vger.kernel.org, linux-wpan@vger.kernel.org

On 6/24/17 5:35 AM, Matthias Schiffer wrote:
> The following functions are extended with a netlink_ext_ack argument to
> allow extended error reporting:
> 
> * validate
> * newlink
> * changelink
> * slave_validate
> * slave_changelink

I would prefer separate patches for validate, slave_validate, newlink,
changelink, and slave_changelink. I do not believe there is a reason to
lump them into 1 giant patch.
