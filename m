Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794156576;
	b=kQ6QO4J7ILHqk/EH+tRqbKXpf5SNvbT/1z5Qitbah3y/Cqhf49ulzXsNxOdqMHOcsGox
	 unBKzTfsTKod51Uon5tvb0hQz0m5+69ISyVG7GfFTpg7oke1FcQkCRhcCTJMmlxa36vg2
	 RrGYYloPpRXqaNmW5NjGNWZSUOqMUAJSiWIMRV1XxQc/cDX9UIGmcibAYJSkfHHj1hRyG
	 npe/l1k1JeYQjWO7vY1GDNcQGoWaVqV403F7gbck23rIuU85UTNetifFVZKKPZiZaGmpK
	 nyGrdaVUtFAvt2r24drfH5NEH17lFJTNQRdfgI8eUHpJbuvFTEBnWzP6orUy69zueSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794156576;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wTb/47UcyVRYUioaA5KlxtEKIzWmzjTjIZZpMNujhtE=;
	b=5e+APlDbtMbY1Io82mtoIcNg1m4hdiGw68GejK1dXPx9zEOMlBsQx1aKthifOnzoNGmn
	 aXDDcl1HeF0BTgqjua0sBMM/hEFEVd6s4L677Eq7709qjDgT6bwJGCB5rtSBvuzwOeoFa
	 5a+B4Rx1bucZzAs07rDaKZFakQZOb4EtK7Wk1LTfXY3QSVwurquVvqKaO1mK+oJ4UDiSE
	 bz3Gm5b1G30CTa3zFniyxqbLitsLWEU1kQ6ENDIEg/9rNaRPs9wFKmm9pnA6DyiQXvOfs
	 0ziQnHXFE1UWOFxeM2W4z9+fK9+d2xonqCo7OzOGTX4yTYBN5VQ/e0VihYSL0FxfHPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYmne0fR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BCB606A31C;
	Sun,  8 Nov 2026 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYmne0fR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02C51F0089F;
	Sun,  8 Nov 2026 16:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794156575;
	bh=wTb/47UcyVRYUioaA5KlxtEKIzWmzjTjIZZpMNujhtE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UYmne0fRrzpbw9ka2R/OPaMJhUJCf1NMVPojgiKMkPcpbZje79AQb1SGFpLCXxhkb
	 wwW2B2lHgHSUxdcxkrj4aJpNE7tlB/5YZRmvm20ggB4wXVVe08RwR8UXVb1xbT/gXr
	 Hp2n0E+zNHsukXpWGFuV2k3pBR47khWDScvD2fHn1+c8iuYtpw0hV8xbYzy4Z/w5ta
	 117yOG06CPUazpWj0ajXFeUCNquEox5v2qFxlGNZ+cqym17k4MdO0sPYS1K9wNLNMJ
	 VragFA13dcXo+wtQ1a1QVugnDT4IFmtCD8S+XBNJCxQz3wHpZZ4aa33FWsOF9GTe05
	 bVxY+itjoEtBA==
Subject: Re: [PATCH net v3] tun: disallow setting IEEE 802.15.4 and 6LoWPAN
 link types via TUNSETLINK
From: netdev-bot+sashiko@kernel.org
To: skalpesh942@gmail.com
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Date: Sun, 08 Nov 2026 16:49:34 +0000
Message-ID: <179415657425.994134.6934756504631104238@kernel.org>
In-Reply-To: <20261107162649.282982-1-skalpesh942@gmail.com>
References: <20261107162649.282982-1-skalpesh942@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new TUNSETLINK denylist in __tun_chr_ioctl()
  (drivers/net/tun.c:3365-3368) can be bypassed by setting high bits in…
- [Low] The commit message gets the root cause wrong.

--

tun: disallow setting IEEE 802.15.4 and 6LoWPAN link types via TUNSETLINK

This patch makes TUNSETLINK return -EINVAL when the requested link type is
ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR or ARPHRD_6LOWPAN. The goal is
to keep code that expects 802.15.4 or 6LoWPAN private data from treating
TUN devices as those device types.

Closes: https://syzkaller.appspot.com/bug?extid=9ea34da5ca6100593c90

> A userspace application can set the link type of a TUN/TAP interface
> to ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR, or ARPHRD_6LOWPAN
> via ioctl(fd, TUNSETLINK, arg) because tun_get_addr_len() explicitly
> recognized these types.

[Severity: Low]
Is this the actual root cause?

tun_get_addr_len() only maps a type to an address length. Its default case
returns 0 for any type it doesn't list, so it never accepts or rejects a
type.

The TUNSETLINK branch in __tun_chr_ioctl() stores whatever value userspace
passes:

    tun->dev->type = (int) arg;

That means these types could be set the same way before cca8ea3b05c9.
Would it be more accurate to say that TUNSETLINK accepts arbitrary type
values?

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e6011..05eb28578b8b0 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3362,6 +3362,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  			netif_info(tun, drv, tun->dev,
>  				   "Linktype set failed because interface is up\n");
>  			ret = -EBUSY;
> +		} else if (arg == ARPHRD_IEEE802154 ||
> +			   arg == ARPHRD_IEEE802154_MONITOR ||
> +			   arg == ARPHRD_6LOWPAN) {
> +			ret = -EINVAL;

[Severity: High]
Can this check be bypassed by setting bits above the low 16 bits of arg?

Here arg is an unsigned long. On the compat path it is a 32-bit value,
because tun_chr_compat_ioctl() only does arg = (compat_ulong_t)arg. But
net_device::type is an unsigned short:

include/linux/netdevice.h:
    unsigned short		type;

Later in the same branch, __tun_chr_ioctl() stores the value like this:

    tun->dev->type = (int) arg;
    tun->dev->addr_len = tun_get_addr_len(tun->dev->type);

With arg = 0x10324, the comparison against ARPHRD_IEEE802154 (0x324) is
false, so the else branch runs. dev->type then ends up as 0x324, which is
ARPHRD_IEEE802154, and tun_get_addr_len() returns the 802.15.4 extended
address length.

0x10325 and 0x10339 work the same way for ARPHRD_IEEE802154_MONITOR and
ARPHRD_6LOWPAN. This also works from 32-bit userspace through the compat
path.

The code named in the commit message only checks the 16-bit dev->type.
Here is ieee802154_llsec_dump_table():

    if (idx < first_dev || dev->type != ARPHRD_IEEE802154)
        goto skip;

    data.ops = ieee802154_mlme_ops(dev);

And here is lowpan_event() handling NETDEV_DOWN:

    if (dev->type != ARPHRD_6LOWPAN)
        return NOTIFY_DONE;
    ...
    clear_bit(LOWPAN_IPHC_CTX_FLAG_ACTIVE,
              &lowpan_dev(dev)->ctx.table[i].flags);

So it looks like an unprivileged user in a user+net namespace can still
trigger both the syzbot NULL dereference and the write into tun_struct
through lowpan_dev().

v2 had an arg > USHRT_MAX check that covered this case, and v3 dropped it
as unrelated. Should the comparison use (u16)arg, or should values above
USHRT_MAX be rejected?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107162649.282982-1-skalpesh942%40gmail.com
