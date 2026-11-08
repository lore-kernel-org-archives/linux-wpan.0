Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794105024;
	b=Uefl0O5C+wAZROjRYE4f/B54aCfdHFX/QiVpHXbLc1CBoY2frU8TvqJ2igojpTG1vMaK
	 1GSJ/c56S971yRe4daU9qiaKriqZ9oVN3z53dRTFfR9tVBfYpSdujzMe5YAFlcIXYyO/U
	 1QT39d9s2k4gawdkdO95lim16mdOmypYGNjp2goBEp1ZGYnP82g5Ztqm7HzwNKRQ06jd9
	 zCxqtNt0gdAYj/0z2aexEF71lXPLownMQTpyYrZyel6uX+qkhmIj88Iy9BxXM4HL2hYW0
	 qRtlWC9bNaSETGgcecJzjEn+oZ8q11sARKHxBWDHc+2selDGtn7T+Yuga/C0f4c4d2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794105024;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1lWeEyUKuoZkaOXEyaoOnoSDcXqbGvsVOE/foLlRDoU=;
	b=5LlFg9R6A1vQsYATEAe47qc7PCEYTWRJCCAexkEXyqmpBgrEtYUU15vfuSPr+Jd+dMPL
	 MG4WoLI761Z11nh8qZh8DGt2fv3udk9Ofok1hUEyEvWdf3YRta/xejK5cR70KOS6TKt+t
	 SWUYo9PMNyab1+RI/OvWgUo3SsyAWcXnfiqdKS9Ne34aymnOTBcIoNObw0j+R7ahjhUZ4
	 pQRyMMtNNmf55r33Q5A1k1HO2pz7hCdhNipZo+2SKi1SkRZ5i+KbfW+P5npF3poDoMszM
	 VNXnuLjHgGOV3XCM1VofIcLE0RKdRHsbPh31ZVI3B0FRtfUTDDWfuXutfo5+o/pl8kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZN3Hj6J3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D504606A31A;
	Sun,  8 Nov 2026 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZN3Hj6J3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD6E1F0089F;
	Sun,  8 Nov 2026 02:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794105023;
	bh=1lWeEyUKuoZkaOXEyaoOnoSDcXqbGvsVOE/foLlRDoU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZN3Hj6J3ehaoFn35x3uJX+ELV6YCIBN1QchPYpOo+g/TQA8K8BKLYWlW2+62XyqNW
	 2kO3hhJ9Islqls7ilR6Kwi8UQx4ODvN+0SewwFEVzQVhJasbTVyZbQzzo4MjXdWI5g
	 1V2FdIZBYI1MnDaQoin/2IqKiwGTej+FGXAhxJOhc8ZiaeFN426iq0rp8mota6trs+
	 ARkimQNuzYGcz/df46meIrWZBmHJZdLwg2NsHl9+jAGU17PN4N4w9XcU8p+ARD3pmM
	 NFcyumxJglm3Ekv23e0ZwhP+2DHLY4PXgKlLugYb77lM6OBoqUM3I/yAoNqKrA8QOd
	 yuVwKBbWOKjUw==
Subject:
 Re: [PATCH] ieee802154: atusb: drop the URB reference after a failed resubmit
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: stefan@datenfreihafen.org, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org
Date: Sun, 08 Nov 2026 02:30:22 +0000
Message-ID: <179410502269.994134.4476899141931304112@kernel.org>
In-Reply-To: <20261104021458.1468481-1-vulab@iscas.ac.cn>
References: <20261104021458.1468481-1-vulab@iscas.ac.cn>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete, and the commit message describes the bug
  wrongly.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  atusb_disconnect() (drivers/net/ieee802154/atusb.c) kills and frees…
- [High] This problem wasn't introduced by this patch, but the lifetime
  of the delayed work atusb->work (embedded in hw->priv) is guarded only…

--

ieee802154: atusb: drop the URB reference after a failed resubmit

This patch adds a usb_free_urb() call to atusb_work_urbs(). The call runs
after a failed atusb_submit_rx_urb() has put the URB back on the idle
anchor. Its purpose is to drop the reference that usb_get_from_anchor()
hands to the caller.

> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> index 5f7fc4ee7a071..c924f17171f46 100644
> --- a/drivers/net/ieee802154/atusb.c
> +++ b/drivers/net/ieee802154/atusb.c
> @@ -183,6 +183,7 @@ static void atusb_work_urbs(struct work_struct *work)
>  	} while (!ret);
>  
>  	usb_anchor_urb(urb, &atusb->idle_urbs);
> +	usb_free_urb(urb);

[Severity: High]
Doesn't the reference from usb_get_from_anchor() also leak when
atusb_submit_rx_urb() succeeds?

The commit message says:

    When atusb_submit_rx_urb() fails, that reference is not consumed,

On success, atusb_submit_rx_urb() doesn't consume it either.
usb_anchor_urb(urb, &atusb->rx_urbs) takes its own reference, and
usb_hcd_submit_urb() takes another. The loop then fetches the next URB
without dropping the caller's reference:

	do {
		urb = usb_get_from_anchor(&atusb->idle_urbs);
		if (!urb)
			return;
		ret = atusb_submit_rx_urb(atusb, urb);
	} while (!ret);

The refcount through one successful RX cycle:

  on idle_urbs                                   1
  usb_get_from_anchor() (caller owns it)         1
  usb_anchor_urb(urb, &atusb->rx_urbs)           2
  usb_hcd_submit_urb()                           3
  __usb_hcd_giveback_urb()->usb_unanchor_urb()   2
  atusb_in()->usb_anchor_urb(idle_urbs)          3
  __usb_hcd_giveback_urb()->usb_put_urb()        2

So the URB goes back on idle_urbs with 2 references instead of 1, and
each later successful cycle adds one more. atusb_in() reschedules the
work for every received frame, so this is the normal RX path, not an
error path.

On disconnect, atusb_in() does not re-anchor URBs that were killed with
-ENOENT, and atusb_free_urbs() drops only one reference per idle URB.
Wouldn't every URB that was ever submitted successfully then leak on each
disconnect or unbind?

Would it be better to drop the reference after every
atusb_submit_rx_urb() call, success or failure, re-anchoring to idle_urbs
first on failure? carl9170_usb_submit_rx_urb() and btusb's play_deferred()
both do this:

	urb = usb_get_from_anchor(&ar->rx_pool);
	if (urb) {
		usb_anchor_urb(urb, &ar->rx_anch);
		err = usb_submit_urb(urb, gfp);
		if (unlikely(err)) {
			usb_unanchor_urb(urb);
			usb_anchor_urb(urb, &ar->rx_pool);
		} else {
			...
		}
		usb_free_urb(urb);
	}

That would replace the failure-only drop, and the commit message would
need updating to match.

>  	dev_warn_ratelimited(&usb_dev->dev,
>  			     "atusb_in: can't allocate/submit URB (%d)\n", ret);
>  	schedule_delayed_work(&atusb->work,

[Severity: High]
This isn't a bug introduced by this patch, but can atusb_xmit() use
atusb->tx_urb after disconnect has freed it?

atusb_disconnect() frees tx_urb before it unregisters the hw:

drivers/net/ieee802154/atusb.c:atusb_disconnect() {
    ...
	usb_kill_urb(atusb->tx_urb);
	usb_free_urb(atusb->tx_urb);

	ieee802154_unregister_hw(atusb->hw);
    ...
}

The wpan interface stays registered and up until
ieee802154_unregister_hw()->ieee802154_remove_interfaces() runs. A frame
sent in that window goes through:

ieee802154_subif_start_xmit()
  ieee802154_hot_tx()
    ieee802154_tx()
      drv_xmit_async()
        atusb_xmit()

None of these functions checks for teardown. atusb_xmit() then writes
into the freed URB and submits it:

	usb_fill_control_urb(atusb->tx_urb, usb_dev,
			     usb_sndctrlpipe(usb_dev, 0),
			     (unsigned char *)&atusb->tx_dr, skb->data,
			     skb->len, atusb_xmit_complete, NULL);
	ret = usb_submit_urb(atusb->tx_urb, GFP_ATOMIC);

After a sysfs unbind the device is still attached, so the submit can
succeed and the host controller works on freed memory.

Should ieee802154_unregister_hw() be called before the URBs are killed
and freed?

[Severity: High]
This is a pre-existing issue, but can atusb->work still be queued when
ieee802154_free_hw() frees it?

The delayed work is embedded in hw->priv. Its lifetime is guarded only by
the plain atusb->shutdown flag, which is read without a lock, and by one
cancel_delayed_work_sync() early in atusb_disconnect():

	atusb->shutdown = 1;
	cancel_delayed_work_sync(&atusb->work);

	usb_kill_anchored_urbs(&atusb->rx_urbs);

There seem to be three ways for the work to be queued after that cancel,
or freed without ever being cancelled.

First, atusb_in() checks the flag and then acts on it with nothing
holding it stable:

	usb_anchor_urb(urb, &atusb->idle_urbs);
	if (!atusb->shutdown)
		schedule_delayed_work(&atusb->work, 0);

CPU1 (atusb_in)                 CPU2 (atusb_disconnect)
reads shutdown == 0
                                atusb->shutdown = 1;
                                cancel_delayed_work_sync() (nothing queued)
schedule_delayed_work()
                                usb_kill_anchored_urbs(&atusb->rx_urbs)

usb_kill_anchored_urbs() only waits for the completion handler to finish.
It does not cancel the work that the handler queued.

Second, atusb_start() queues the work without checking shutdown:

drivers/net/ieee802154/atusb.c:atusb_start() {
    ...
	schedule_delayed_work(&atusb->work, 0);
    ...
}

The netdev stays registered until ieee802154_unregister_hw(), which runs
after the cancel. Bringing the interface up in that window queues work
that nothing cancels, because atusb_stop() only kills idle_urbs.

Third, the atusb_probe() error path that runs after
ieee802154_register_hw() has succeeded:

	ieee802154_unregister_hw(hw);
fail:
	atusb_free_urbs(atusb);
	usb_kill_urb(atusb->tx_urb);
	usb_free_urb(atusb->tx_urb);
	ieee802154_free_hw(hw);

Once register_hw has succeeded, userspace can bring wpan0 up. That runs
atusb_start() and then the work, which submits RX URBs to rx_urbs. If the
final atusb_get_and_clear_error() then fails, this path never calls
cancel_delayed_work_sync() and never kills rx_urbs. The in-flight RX URBs
hold skbs with SKB_ATUSB(skb) == atusb.

Could the queued work, or those URB completions, then touch the freed
atusb?

Should the work be cancelled again after the last point that can queue
it, and should rx_urbs be killed, on both the disconnect path and the
probe error path?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104021458.1468481-1-vulab%40iscas.ac.cn
